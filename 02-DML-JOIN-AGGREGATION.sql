--------------
-----JOIN-----
--------------
-- employees와 departments
DESC Employees;
DESC Departments;

SELECT *
FROM employees, departments;
-- 카티전 프로덕트

SELECT *
FROM Employees, Departments
WHERE Employees.department_id = Departments.department_id;
-- INNER JOIN, EQUI-JOIN


-- ALIAS를 이용한 원하는 필드의 Projection
----------------------------
--SIMPLE JOIN OR EQUI-JOIN--
----------------------------
SELECT e.first_name,
e.department_id,
d.department_id,
d.department_name
FROM Employees e, Departments d
WHERE e.department_id = d.department_id;
--department_id 가 NULL인 직원은 JOIN에서 제외

SELECT e.first_name,
d.department_name
FROM Employees e
JOIN Departments d USING (department_id);

SELECT e.first_name,
d.department_name
FROM Employees e
JOIN Departments d ON e.department_id=d.department_id;

------------------
----THETA JOIN----
------------------
-- JOIN 조건이 = 아닌 다른 조건들
-- 급여가 직군의 평균 급여보다 낮은 직원들의 목록
SELECT e.employee_id,
e.first_name,
e.salary,
j.job_id,
j.job_title
FROM Employees e, Jobs j
WHERE e.salary <= 8000
ORDER BY salary DESC;

---------------------
-----OUTER JOIN------
---------------------
-- 조건을 만족하는 짝이 없는 튜플도 NULL을 포함해서 결과 출력에 참여시키는 방법
-- 모든 결과를 표현한 테이블이 어느 쪽에 위치하는가에 따라 LEFT, RIGHT, FULL OUTER JOIN으로 나뉜다. 
-- Oracle SQL의 경우, NULL이 출력되는 쪽에 (+)를 붙인다.

----------------------
------LEFT JOIN-------
----------------------
-- Oracle SQL
SELECT e.first_name,
       e.department_id,
       d.department_id,
       d.department_name
FROM Employees e, Departments d
WHERE e.department_id = d.department_id (+); -- NULL이 포함된 테이블 쪽에 (+) 표기

SELECT * FROM Employees WHERE department_id IS NULL;

-- ANSI SQL = 일시적으로 JOIN 방법을 정한다. 
SELECT first_name, 
e.department_id,
department_name
FROM Employees e 
LEFT OUTER JOIN Departments d ON e.department_id=d.department_id;

--------------------
------RIGHT JOIN----
--------------------
-- RIGHT 테이블의 모든 레코드가 출력 결과에 참여

-- Oracle SQL
SELECT first_name,
       e.department_id,
       d.department_id,
       department_name
FROM employees e, Departments d
WHERE e.department_id(+) = d.department_id; -- departments 테이블 레코드 전부를 출력에 참여 -- 122 레코드

--------------------
-- FULL OUTER JOIN--
--------------------
-- JOIN에 참여한 모든 테이블의 모든 레코드를 출력에 참여
-- 짝이 없는 레코드들은 NULL을 포함해서 출력에 참여

-- ANSI SQL
SELECT first_name,
       e.department_id,
       d.department_id,
       department_name
    FROM Employees e
        FULL OUTER JOIN Departments d
            ON e.department_id = d.department_id;
            
----------------
--NATURAL JOIN--
----------------
-- JOIN할 테이블에 같은 이름의 컬럼이 있을 경우, 해당 컬럼을 기준으로 JOIN
SELECT * FROM Employees e NATURAL JOIN Departments d;

SELECT * FROM Employees e JOIN Departments d ON e.department_id = d.department_id;
SELECT * FROM Employees e JOIN Departments d ON e.manager_id = d.manager_id;

-------------
--SELF JOIN--
-------------
-- 자기 자신과 JOIN
-- 자신을 두 번 호출 -> 별칭을 반드시 부여해야 할 필요가 있는 JOIN
SELECT * FROM Employees;
SELECT e.employee_id,
       e.first_name,
       e.manager_id,
       man.first_name
    FROM Employees e JOIN Employees man
    ON e.manager_id=man.employee_id;
    
----------------------
-- GROUP AGGREGATION--
----------------------
--집계: 여러 행으로부터 데이터를 수집, 하나의 행으로 반환

-- COUNT: 갯수 세기 함수
-- Employees 테이블의 총 레코드 갯수?
SELECT COUNT(*)
FROM Employees;
---> *로 카운트 하면 모든 행의 수를 반환
-- 특정 컬럼 내에 NULL 값이 포함되어 있는지의 여부는 중요하지 않음

-- commission을 받는 직원의 수를 알고 싶을 경우,
-- commission_pct가 NULL인 경우를 제외하고 싶을 때
SELECT COUNT(commission_pct)
FROM Employees;
-- 컬럼 내에 포함된 NULL 데이터를 카운트하지 않음
-- 위 쿼리는 아래 쿼리와 같다.
SELECT COUNT(*) FROM Employees
WHERE commission_pct IS NOT NULL;

-- SUM: 합계 함수
-- 모든 사원의 급여의 합계
SELECT SUM(salary)
FROM Employees;
-- AVG: 평균 함수
-- 사원의 평균 급여는?
SELECT AVG(salary)
FROM Employees;
-- 사원들이 받는 커미션 비율의 평균은 얼마인가?
SELECT AVG(commission_pct)
FROM Employees;
-- AVG 함수는 NULL 값이 포함되어 있을 경우 그 값을 집계 수치에서 제외한다.
-- NULL 값을 집계 결과에 포함시킬지의 여부는 정책으로 결정하고 수행해야 한다. 
SELECT AVG(NVL(commission_pct,0)) 
FROM Employees;

-- MAX / MIN / AVG / MEDIAN
-- 최대값/최소값/산술평균/중앙값
-- 최고 급여는?
SELECT MAX(salary),
       MIN(salary),
       AVG(salary),
       MEDIAN(salary)
FROM Employees;

-- 흔히 범하는 오류
-- 부서별로 평균 급여를 구하고자 할 때
SELECT e.department_id 부서ID, 
d.department_name 부서명, 
e2.first_name 매니저, 
ROUND(AVG(e.salary)) "평균 급여"
FROM Employees e
JOIN Departments d ON e.department_id=d.department_id
JOIN Employees e2 ON e.manager_id=e2.employee_id
GROUP BY e.department_id, d.department_name, e2.first_name
ORDER BY "평균 급여" DESC;

-- ORDER BY 절 이후에는 GROUP BY에 참여한 컬럼과 집계 함수만 남는다. 
-- 평균 급여가 7,000 이상인 부서만 출력
SELECT department_id, 
       AVG(salary) 평균급여
    FROM Employees
    WHERE AVG(salary) >= 7000 -- 아직 집계 함수 시행되지 않은 상태 -> 집계 합수의 비교 불가
    GROUP BY department_id
    ORDER BY department_id ASC;
    
    SELECT department_id 부서명, COUNT(*) 인원수, SUM(salary) "급여 합계"
        FROM Employees
        GROUP BY department_id
        HAVING SUM(salary) > 20000;
        
-- 집계 함수 이후의 조건 비교 HAVING 절을 이용
SELECT department_id,
       ROUND(AVG(salary))
    FROM Employees
    GROUP BY department_id
        HAVING AVG(salary) >= 7000 -- GROUP BY aggregation의 조건 필터링
    ORDER BY department_id;
    
-- ROLLUP
-- GOURP BY 절과 함께 사용
-- 그룹지어진 결과에 대한 좀 더 상세한 요약을 제공하는 기능 수행
-- 일종의 ITEM TOTAL
SELECT
    department_id,
    job_id,
    SUM(salary)
FROM Employees
GROUP BY ROLLUP(department_id, job_id);

-- CUBE
-- CrossTab에 대한 Summary를 함께 추출하는 함수
-- Rollup 함수에 의해 출력되는 Item Total 값과 함께
-- Column Total 값을 함께 추출
SELECT
    department_id,
    job_id,
    SUM(salary)
FROM Employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id;

-----------------------
----- SUBQUERRY -------
-----------------------
-- 모든 직원 급여의 중앙값보다 많은 급여를 받는 사원의 목록
-- 1) 직원 급여의 중앙값은?
-- 2) 1) 결과보다 많은 급여를 받는 직원의 목록

SELECT first_name, salary
FROM Employees
WHERE salary >= -- 6200(MEDIAN값)
(SELECT MEDIAN(salary)
FROM Employees
);

-- SUSAN 보다 늦게 입사한 사원의 정보
-- 1) SUSAN의 입사일
-- 2) 늦게 입사한 사원의 정보를 추출
SELECT first_name, hire_date
FROM Employees
WHERE hire_date > (
SELECT hire_date
FROM Employees
WHERE first_name = 'Susan'
)
ORDER BY hire_date ASC;

-- 연습문제)
-- 급여를 모든 직원 급여의 중앙값보다 많이 받으면서 수잔보다 늦게 입사한 직원의 목록
SELECT first_name, hire_date, salary
FROM Employees
WHERE hire_date > (
        SELECT hire_date
        FROM Employees
        WHERE first_name = 'Susan'
        )
AND salary > (
        SELECT MEDIAN(salary)
        FROM Employees
        )
    ORDER BY hire_date ASC,
             salary DESC;
             
-- 연습문제) SCOTT보다 급여가 많은 사람의 이름은?
SELECT first_name, salary
FROM Employees
WHERE salary > (
SELECT salary 
FROM Employees
WHERE first_name = 'Trenna'
)
ORDER BY salary ASC;

-- 다중형 서브쿼리
-- 서브쿼리 결과가 둘 이상의 레코드일 때, 단일행 비교연산자는 사용 X
-- 집합연산에 관련된 IN, ANY, ALL, EXIST 등을 사용해야 한다
--[연습] 직원들 중, 110번 부서 사람들이 받는 급여와 같은 급여를 받는 직원들의 목록
SELECT first_name, salary
    FROM Employees
WHERE salary IN (
        SELECT salary 
        FROM Employees
        WHERE department_id = 110)
    ORDER BY salary DESC;
        
-- Correlated Querry : 연관 쿼리
-- 바깥쪽 쿼리(Outer Querry)와 안쪽 쿼리(Inner Querry)가 서로 연관된 쿼리
SELECT
    first_name,
    salary,
    department_id
FROM Employees OUTER
WHERE salary > (SELECT AVG(salary)
                FROM Employees
                WHERE department_id = OUTER.department_id);
-- 외부 쿼리: 급여를 특정 값보다 많이 받는 직원의 이름, 급여, 부서ID

-- 내부 쿼리: 특정 부서에 소속된 직원의 평균 급여

-- 자신이 속한 부서의 평균 급여보다 많이 받는 직원의 목록을 구하라는 의미
-- 외부 쿼리가 내부 쿼리에 영향을 미치고, 내부 쿼리 결과가 다시 외부 쿼리에 영향을 미침
-- 내부 쿼리 결과가 다사ㅣ 외부 쿼리에 영향을 미침

-- 서브쿼리 연습
-- 각 부서별로 최고 급여를 받는 사원의 목록(조건절에서 서브쿼리 활용)
SELECT d.department_name 부서명, 
       e.first_name || ' ' || e.last_name 사원명, 
       e.salary 최고급여
    FROM Employees e
    JOIN Departments d ON e.department_id = d.department_id
        WHERE e.salary = (
        SELECT MAX(salary)
        FROM Employees
        WHERE department_id=e.department_id
        )
    ORDER BY salary DESC;
    
    SELECT e.job_id 업무ID,
           e.salary 평균급여
        FROM Employees e
        WHERE e.salary = (
        SELECT AVG(salary)
            FROM Employees
            WHERE job_id=e.job_id
            );
    
-- TOP-K 쿼리
-- 질의의 결과로 부여된 가상 컬럼 rownum 값을 사용해서 쿼리 순서 반환
-- rownum 값을 활용 상위 k개의 값을 얻어오는 쿼리

-- 2017년 입사자 중에서 연봉 순위 5위까지 출력

-- 1. 2017년 입사자는 누구?
SELECT * FROM Employees
WHERE hire_date Like '17%'
AND rownum < 6
ORDER BY salary DESC;

SELECT first_name,
       hire_date,
       salary
    FROM (
           SELECT *
           FROM Employees
           WHERE hire_date Like '17%'
           AND rownum < 6
           ORDER BY salary ASC
            );
    
-- 집합 연산
SELECT first_name, salary, hire_date FROM Employees WHERE hire_date < '15/01/01';
SELECT first_name, salary, hire_date FROM Employees WHERE salary > 12000;

-- 합집합(중복 미포함)
SELECT first_name, salary, hire_date FROM Employees WHERE hire_date < '15/01/01'
UNION 
SELECT first_name, salary, hire_date FROM Employees WHERE salary > 12000;

-- 중복 레코드는 별개로 취급(중복 포함)
SELECT first_name, salary, hire_date FROM Employees WHERE hire_date < '15/01/01'
UNION ALL 
SELECT first_name, salary, hire_date FROM Employees WHERE salary > 12000;

-- 교집합
SELECT first_name, salary, hire_date FROM Employees WHERE hire_date < '15/01/01'
INTERSECT --> INNER JOIN과 같은 결과
SELECT first_name, salary, hire_date FROM Employees WHERE salary > 12000;

-- 차집합
SELECT first_name, salary, hire_date FROM Employees WHERE hire_date < '15/01/01'
MINUS --
SELECT first_name, salary, hire_date FROM Employees WHERE salary > 12000;

--RANK 관련 함수
SELECT salary, first_name, 
        RANK() OVER (ORDER BY salary DESC) as rank, -- 일반적인 순위
        DENSE_RANK() OVER (ORDER BY salary DESC) as dense_rank, -- 
        ROW_NUMBER() OVER (ORDER BY salary DESC) as row_number, -- 정렬했을 때의 실제 행번호
        rownum AS "rownum"
        FROM Employees;
        
-- Hierarchial Query
-- 트리 형태 구조 표현
-- level 가상 컬럼 활용 쿼리
SELECT level, first_name
FROM Employees
START WITH manager_id IS NULL -- 트리 형태의 root가 되는 조건 명시
CONNECT BY PRIOR employee_id = manager_id -- 상위 레벨과의 연결 조건 (가지치기 조건)
ORDER BY level; -- 트리의 길이를 나타나는 Oracle 가상 컬럼
    
-- 자체문제: 'Marketing' 부서에서 급여가 높은 순으로 5명의 사원 추리기
SELECT e.first_name || ' ' || e.last_name,
       d.department_name,
       e.salary,
       e.hire_date
    FROM Employees e
        JOIN Departments d ON e.department_id=d.department_id
        WHERE d.department_name = 'Marketing'
        ORDER BY e.salary DESC;
               
        