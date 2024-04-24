-- SQL 문장의 주석
-- SQL 문장은 마지막에 세미콜론(;)으로 끝난다. 
-- 키워드들, 테이블명, 컬럼 등은 대소문자 구분하지 않는다. 
-- 실제 데이터의 경우, 대소문자를 구분한다.

-- 테이블 구조 확인 (DESCRIBE)
DESCRIBE employees;
describe COUNTRIES;
describe departments;
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    age NUMBER,
    major VARCHAR2(100)
    );
    INSERT INTO Students (student_id, name, age, major) VALUES (1, '홍길동', 20, '컴퓨터공학');
    INSERT INTO Students (student_id, name, age, major) VALUES (2, '김철수', 22, '경영학');
    
    SELECT * FROM Students;
    SELECT name, major FROM Students WHERE age > 21;
    UPDATE Students SET age = 23 WHERE student_id=1;
    DELETE FROM Students WHERE student_id=2;
    
    CREATE TABLE Employeess (
    employee_id NUMBER PRIMARY KEY,
    f_name VARCHAR2(10),
    l_name VARCHAR2(10),
    salary2 number(10),
    manager_idd CHAR(3)
    );
    INSERT INTO Employeess (employee_id, f_name, l_name, salary2, manager_idd) VALUES (100, 'Steven', 'King', 24000, null);
    SELECT * FROM Employeess;
    ALTER TABLE Employeess DROP COLUMN manager_idd;
    DROP TABLE Employeess;
    
    
    SELECT first_name FROM Employees WHERE salary > 10000;
    
    -- DML(Data Manipulation Language)
    -- SELECT
    -- * : 테이블 내의 모든 컬럼 Projection, 테이블 설계시에 정의한 순서대로
    SELECT * FROM Employees;
    
    -- 특정 컬럼만 Projection 하고자 하면 열 목록을 명시
    
    -- Employees 테이블의 first_name, phone_number, hire_date, salary만 보고 싶다면,
    SELECT first_name, phone_number, hire_date, salary FROM Employees;
    
    -- 사원의 이름, 성, 급여, 전화번호, 입사일 정보 출력
    SELECT last_name, first_name, salary, phone_number, hire_date FROM Employees;
    
    -- 산술연산: 기본적인 산술연산을 수행할 수 있다. 
    -- 특정 테이블의 값이 아닌 시스템으로부터 데이터를 받아오고자 할 때: dual (가상테이블)
    SELECT 3.14159 * 10 * 10 FROM dual;
    
    -- 특정 컬럼의 값을 산술 연산에 포함
    SELECT first_name 이름, salary 월급, salary*12 연봉, 100*12 뽀나쓰, (salary + 100) *12 뽀나쓰_포함_최종연봉 FROM Employees;
    
    -- 오류의 원인 찾기: job_id는 문자열(VARCHAR2)
    SELECT job_id*12 FROM Employees;
    SELECT * FROM Employees;
    DESC Employees;
    
    -- ex)01: 사원의 이름(first_name)과 전화번호, 입사일, 급여 출력
    SELECT first_name, phone_number, hire_date, salary FROM Employees;
    -- ex)02: 사원의 이름(first_name)과 성(last_name), 급여, 전화번호, 입사일 출력
    SELECT first_name, last_name, salary, phone_number, hire_date FROM Employees;
    SELECT 12 FROM dual;
    
    -- NULL은 0이나 ""와 다르게 빈 값이다. 
    -- 산술계산에 NULL이 포함된 경우, 모든 결과 값은 NULL
    -- NULL은 산술계산 결과, 통계 결과 등을 왜곡하기 -> NULL에 대한 처리는 철저하게
    SELECT salary + salary * commission_pct FROM Employees;
    
    -- NVL(expr1, expr2): NULL 처리 함수 (expr1이 NULL이면 expr2를 출력) (해당 column의 데이터 타입과 일치해야)
    SELECT first_name 이름, salary 급여, salary * NVL(commission_pct,0) 커미션, salary+salary*NVL(commission_pct,0) 최종급여 FROM Employees;
    SELECT first_name as 이름, NVL(commission_pct,0) as 커미션 FROM Employees;
    
    -- 문자열 합치기
    -- 1. CONCAT(2개 테이블만 가능)
    -- 2. || 활용(그 이상도 가능)
    SELECT first_name || ' ' || last_name || '의 월급은 ' || salary || '달러 입니다.' as 월급 FROM Employees;
    SELECT CONCAT(first_name, last_name) FROM Employees;
    
    -- 별칭 Alias
    -- Projection 단계에서 출력용으로 표시되는 임시 컬럼 제목
    SELECT employee_id as empNO, first_name "E-name", salary "급 여" FROM Employees;
    SELECT first_name 이름, salary 급여, NVL(commission_pct,0) 커미션, salary+salary*NVL(commission_pct,0) "총 급여" FROM Employees;
    
    -- 컬럼명 뒤에 별칭
    -- 컬럼명 뒤에 as 별칭
    -- 표시명에 특수문자 포함된 경우 ""로 묶어서 부여
    -- [예제]
    SELECT first_name || ' ' || last_name 이름, hire_date 입사일, phone_number 전화번호, salary 급여, salary*12 연봉 FROM Employees;
    -- [예제]: 직원 아이디는 empNo, 이름은 E-name, 급여는 월 급 으로 표시
    SELECT employee_id empNo, first_name "E-name", salary "월 급" FROM Employees WHERE salary BETWEEN 7000 AND 10000;
    SELECT first_name 이름, salary "월 급", commission_pct 커미션 FROM Employees WHERE commission_pct IS NOT NULL AND salary>10000;
    SELECT first_name 이름, salary "월 급" FROM Employees WHERE first_name = ANY('John','Karen','Alberto');
    
    -------------
    ----WHERE----
    -------------
    -- 특정 조건을 기준으로 레코드를 선택 (SELECTION)
    -- 비교연산: =, <>, >, >=, <, <=
    -- 사원들 중, 급여가 15,000 이상인 직원의 이름과 급여(+ 커미션 받는 직원)
    SELECT last_name 이름, salary, commission_pct FROM Employees WHERE salary > 10000 AND commission_pct IS NOT NULL;
    -- 입사일이 07/01/01 이후인 직원들의 이름과 입사일
    SELECT last_name 이름, hire_date 입사일, salary 급여 FROM Employees WHERE hire_date > '17/01/01';
    -- 급여가 14,000 이하이거나, 17,000 이상인 사원의 이름과 급여
    SELECT last_name 이름, salary 급여 FROM Employees WHERE salary <= 14000 OR salary >=17000;
    -- 급여가 14,000 이상이고, 17,000 이하인 사원의 이름과 급여, 커미션 받는 자
    SELECT last_name 이름, salary 급여, commission_pct 커미션 FROM Employees WHERE salary >= 14000 AND salary <= 17000 AND commission_pct IS NOT NULL;
    SELECT last_name 이름, salary 급여, commission_pct 커미션 FROM Employees WHERE salary BETWEEN 14000 AND 17000 AND commission_pct IS NOT NULL;
    
    -- IN 연산자: 특정 집합의 요소와 비교
    -- 사원들 중 10, 20, 40번 부서에서 근무하는 직원들의 이름과 부서 아이디
    SELECT last_name 이름, department_id 부서명 FROM Employees WHERE department_id IN (10, 20, 40);
    
    ---------------
    ---LIKE 연산---
    ---------------
    -- 와일드카드(%,_)를 이용한 부분 문자열 매핑
    -- %: 0개 이상의 정해지지 않은 문자열
    -- _: 1개의 정해지지 않은 문자
    -- 이름에 am을 포함하고 있는 사원의 이름과 급여를 출력
    SELECT first_name 이름, salary 급여 FROM Employees WHERE LOWER (first_name) LIKE '%am%';
    -- 이름의 두 번째 글자가 a인 사원의 이름과 급여
    SELECT first_name 이름, salary 급여 FROM Employees WHERE LOWER (first_name) LIKE '_a%';
    -- 이름의 네 번째 글자가 a인 사원의 이름과 급여
    SELECT first_name 이름, salary 급여 FROM Employees WHERE LOWER (first_name) LIKE '___a%';
    -- 이름이 네 글자인 사원들 중에서 두 번째 글자가 a인 사원의 이름과 급여
    SELECT first_name 이름, salary 급여 FROM Employees WHERE LOWER (first_name) LIKE '_a__';