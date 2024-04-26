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
FROM Employees e
JOIN Jobs j ON e.job_id=j.job_id
WHERE e.salary <= (j.min_salary+j.max_salary)/2;

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