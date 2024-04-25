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
    SELECT first_name 이름, salary 급여 
    FROM Employees 
    WHERE LOWER (first_name) 
    LIKE '%am%';
    -- 이름의 두 번째 글자가 a인 사원의 이름과 급여
    SELECT first_name 이름, salary 급여 
    FROM Employees 
    WHERE LOWER (first_name) 
    LIKE '_a%';
    -- 이름의 네 번째 글자가 a인 사원의 이름과 급여
    SELECT first_name 이름, salary 급여 
    FROM Employees 
    WHERE LOWER (first_name) 
    LIKE '___a%';
    -- 이름이 네 글자인 사원들 중에서 두 번째 글자가 a인 사원의 이름과 급여
    SELECT first_name 이름, salary 급여 
    FROM Employees 
    WHERE LOWER (first_name) 
    LIKE '_a__';
    -- 부서 ID가 90인 사원 중 급여가 20,000 이상인 사원의 이름
    SELECT first_name 이름, salary 급여, department_id "부서 아이디" 
    FROM Employees 
    WHERE salary >= 20000 
    AND department_id = 90;
    -- 입사일이 01/01/01 ~ 07/12/31 구간에 있는 사원의 목록
    SELECT first_name 이름, hire_date 입사일 
    FROM Employees 
    WHERE hire_date 
    BETWEEN '11/01/01' AND '17/12/31';
    -- manager_id가 100, 120, 147인 사원의 명단
    SELECT first_name 이름, manager_id 관리자 
    FROM Employees 
    WHERE manager_id 
    IN (100, 120, 147);
    
    --------------
    ---ORDER BY---
    --------------
    -- 특정 컬럼명, 연산식, 별칭, 컬럼 순서를 기준으로 레코드를 정렬
    -- ASC(오름차순): default, DESC(내림차순)
    -- 여러 개의 컬럼에 적용할 수 있고 .로 구분
    
    -- 부서 번호의 오름차순으로 정렬, 부서번호, 급여, 이름 출력
    SELECT department_id 부서번호, salary 급여, first_name 이름 
    FROM Employees 
    ORDER BY department_id ASC;
    -- 급여가 10,000 이상인 직원 대상, 급여의 내림차순으로, 이름, 급여 출력
    SELECT first_name 이름, salary 급여 FROM Employees ORDER BY salary DESC;
    -- 부서 번호, 급여, 이름 순으로 출력, 정렬 기준 부서번호 오름차순, 급여 내림차순
    SELECT department_id "부서 번호", salary 급여, first_name 이름 FROM Employees ORDER BY department_id ASC, salary DESC;
    -- 정렬 기준을 어떻게 세우느냐에 따라 성능, 출력 결과에 영향을 미칠 수 있다. 
    
    --------------
    --단일행 함수--
    --------------
    -- 단일 레코드를 기준으로 특정 컬럼에 값에 적용되는 함수
    -- 문자열 단일행 함수
    SELECT first_name, last_name, 
        CONCAT(first_name, CONCAT(' ', last_name)), -- answkduf dusruf gkatn
        first_name || ' ' || last_name
    FROM Employees;
    
    SELECT first_name, last_name, 
        LOWER(first_name),  -- 모두 소문자
        UPPER(first_name),   -- 모두 대문자
        LPAD(first_name, 20, '*'),  -- 왼쪽에 20자리 *을 추가
        RPAD(first_name, 20, '*')   -- 오른쪽에 20자리 *을 추가
    FROM Employees;
        
    SELECT '    Oracle  ',
        '*****Database*****',
        LTRIM(' Oracle  '), -- 왼쪽의 빈 공간 삭제
        RTRIM(' Oracle  '), --오른쪽의 빈 공간 삭제
        TRIM('*' FROM '*****Database*****'),    --앞뒤의 잡음 문자 제거
        SUBSTR('Oracle Database', 8, 4), -- 8번째 글자부터 4개 글자 추출
        SUBSTR('Oracle Database', -8, 4),    -- 역인덱스 이용 부분 문자열
        LENGTH('Oracle Database')   -- 문자열 길이
        FROM dual;
        
    -- 수치형 단일행 함수
    
    SELECT 3.14159,
        ABS(-3.14),     --절대값
        CEIL(3.14),     --올림
        FLOOR(3.14),    --내림
        ROUND(3.14),    --반올림
        ROUND(3.14159, 3),   -- 소수점 3번째 자리 반올림(4번째에서 반올림함)
        TRUNC(3.5), -- 버림
        TRUNC(3.14159, 3),   -- 소수점 4번째 자리에서 버림
        SIGN(-3.14159),     -- 부호(-1: 음수, 0: 0, 1: 양수)
        MOD (7,3),      -- 7을 3으로 나눈 나머지
        POWER(2,4)      -- 2의 4승
    FROM dual;
    
    ---------------
    --DATE FORMAT--
    ---------------
    -- 현재 세션 정보 확인
    SELECT * FROM nls_session_parameters;
    -- 현재 날짜 포맷이 어떻게 되는가?
    -- 딕셔너리를 확인
    SELECT value FROM nls_session_parameters
    WHERE parameter='NLS_DATE_FORMAT';
    
    -- 현재 날짜: SYSDATE
    -- 가상 테이블 dual로부터 받아오므로 1개의 레코드
    SELECT sysdate FROM dual;
    -- Employees 테이블로부터 받아오므로 Employees 테이블 레코드의 갯수만큼
    SELECT first_name, hire_date, sysdate FROM Employees;
    
    -- 날짜 관련 단일행 함수
    SELECT sysdate,
    --2개월이 지난 후의 날짜
    ADD_MONTHS(sysdate, 2), 
    --현재 달의 마지막 날
    LAST_DAY(sysdate),
    --두 날짜 사이의 개월 차
    MONTHs_BETWEEN(sysdate,'12/09/24'),
    --해당 날짜 이후 처음 오는 요일(일월화 순으로 숫자 입력)
    NEXT_DAY(sysdate,6),
    --MONTH를 기준으로 반올림
    ROUND(sysdate, 'MONTH'),
    --MONTH를 기준으로 내림
    TRUNC(sysdate, 'MONTH')
    FROM dual;
    
    SELECT first_name, hire_date,
        ROUND(MONTHS_BETWEEN(sysdate, hire_date),1) 근속월수
    FROM Employees;
    
    ------------
    --변환함수---
    ------------
    -- TO_NUMBER(s, fmt) : 문자열 -> 숫자
    -- TO_DATE(s, fmt): 문자열 -> 날짜
    -- TO_CHAR(o, fmt) : 숫자, 날짜 -> 문자열
    
    -- TO_CHAR
    SELECT first_name, 
        TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS')
    FROM Employees;
    
    -- 현재 시간을 년-월-일-시-분-초
    SELECT sysdate,
        TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    FROM dual;
    
    SELECT
        TO_CHAR(3000000, 'L999,999,999,999.99')
    FROM dual;
    
    --모든 직원의 이름과 연봉 정보를 표시
    SELECT
        first_name 이름, salary 월급, NVL(commission_pct,0) 커미션, 
        TO_CHAR((salary + salary * NVL(commission_pct, 0))*12, '$999,999,999.99') 연봉
    FROM Employees
    ORDER BY salary ASC;
    
    --문자 -> 숫자: TO_NUMBER
    SELECT '$57, 600',
        TO_NUMBER('$57,600','$999,999.99')/12 월급
    FROM dual;
    
    --문자열 -> 날짜
    SELECT '2012-09-24 13:48:00',
        TO_DATE('2012-09-24 13:48:00', 'YYYY-MM-DD HH24:MI:SS')
        FROM dual;
        
    -- 날짜 연산
    -- Date +/- Number : 특정 일수를 더하거나 뺄 수 있다. 
    SELECT sysdate, 
    sysdate - 16
    FROM dual;
    -- Date - Date : 두 날짜의 경과일수
    SELECT sysdate,
    TO_DATE('24/04/25') - TO_DATE('20240424')
    FROM dual;
    -- Date + Number / 24: 특정 시간이 지난 후의 날짜
    SELECT sysdate,
    sysdate + 48/24 -- 48시간이 지난 후의 날짜
    FROM dual;
    
    -- NVL2 function
    SELECT first_name, 
            salary, 
            NVL2(commission_pct,'O','X') "commission(O,X)", 
            NVL2(salary+salary*commission_pct,salary+salary*commission_pct,salary) "최종 급여" 
    FROM Employees;
    
    -- CASE function
    -- 보너스를 지급하기로 함. 
    -- AD 관련 직종에게는 20%, SA 관련 직원에게는 10%, IT 관련 직원들에게는 8%, 나머지에게는 5%
    SELECT first_name, job_id, salary,
        SUBSTR(job_id,1,2) 직종,
        CASE SUBSTR(job_id,1,2) WHEN 'AD' THEN salary*0.2
                                WHEN 'SA' THEN salary*0.1
                                WHEN 'IT' THEN salary*0.08
                                ELSE salary*0.05
                            END 보너스
    FROM Employees;
    
    -- DECODE 함수
    SELECT first_name, job_id, salary,
        SUBSTR(job_id, 1, 2) 직종,
        DECODE(SUBSTR(1,2),     -- 비교할 값
                    'AD', salary * 0.2,
                    'SA', salary * 0.1,
                    'IT', salary * 0.08,
                    salary * 0.05) bonus
    FROM Employees;
    
    --[연습] hr.employees
    SELECT first_name 이름, department_id 부서ID, 
    CASE WHEN department_id >= 10 AND department_id <= 30 THEN 'A-GROUP'
         WHEN department_id >= 40 AND department_id <= 50 THEN 'B-GROUP'
         WHEN department_id >= 60 AND department_id <= 100 THEN 'C-GROUP'
         ELSE 'REMAINDER'
         END 팀
    FROM Employees
    ORDER BY department_id ASC;
    
   