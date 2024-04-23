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
    INSERT INTO Employeess (employee_id, first_name, last_name, salary, manager_id) VALUES (100, 'Steven', 'King', 24000, null);
    SELECT * FROM Employees;
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
    