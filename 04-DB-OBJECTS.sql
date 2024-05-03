----------------
-- DB OBJECTS --
----------------
-- SYSTEM으로 진횅
-- VIEW 생성을 위한 SYSTEM 권한
GRANT CREATE VIEW TO himedia;

GRANT SELECT ON HR.Employees TO himedia;
GRANT SELECT ON HR.Departments TO himedia;

-- himedia
-- SELECT VIEW
-- 단일 테이블 혹은 단일 뷰를 베이스로 한 함수, 연산식을 포함하지 않은 뷰

-- emp123
DESC emp123;

-- emp123 테이블 기반, department_id = 10 부서 소속 사원만 조회하는 뷰
CREATE OR REPLACE VIEW emp10
    AS SELECT employee_id, first_name, last_name, salary
        FROM emp123
        WHERE department_id = 10;
SELECT * FROM emp10;
SELECT * FROM tabs;
-- 일반 테이블처럼 활용할 수 있음
DESC emp10;

SELECT first_name || ' ' || last_name, salary FROM emp10;

-- SIMPLE VIEW는 제약 사항에 걸리지 않는다면 INSERT, UPDATE, DELETE를 할 수 있다. 
UPDATE emp10 SET salary = salary *2;
SELECT * FROM emp10;
ROLLBACK;

-- 가급적 VIEW는 조회용으로만 활용하자
-- WITH READ ONLY : 읽기 전용 뷰
CREATE OR REPLACE VIEW emp10
    AS SELECT employee_id, first_name, last_name, salary
        FROM emp123
        WHERE department_id = 10
    WITH READ ONLY;
    
    UPDATE emp10 SET salary = salary *2;
    
--COMPLEX VIEW
-- 한 개 혹은 여러 개의 테이블 혹은 뷰에 JOIN, 함수, 연산식 등을 활용한 VIEW
-- 특별한 경우가 아니면 INSERT, UPDATE, DELETE 작업 수행 불가

CREATE OR REPLACE VIEW emp_detail
    (employee_id, employee_name, manager_name, department_name)
    AS SELECT emp.employee_id, 
              emp.first_name || ' ' || emp.last_name, 
              man.first_name || ' ' || man.last_name,
              department_name
        FROM HR.Employees emp 
            JOIN HR.Employees man ON emp.manager_id = man.employee_id
            JOIN HR.Departments dept ON emp.department_id = dept.department_id;
            
DESC emp_detail;
SELECT * FROM emp_detail;

-- VIEW를 위한 DICTIONARY: VIEWS
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_OBJECTS; -- VIEW 포함 모든 DB 객체들의 정보

-- VIEW 삭제: DROP VIEW
-- VIEW 삭제해도 기반 테이블 데이터는 삭제되지 않음
DROP VIEW emp_detail;
SELECT * FROM USER_VIEWS;

-------------
--- INDEX ---
-------------
-- hr.Employees 테이블 복사 s_emp 테이블 생성
CREATE TABLE s_emp
AS SELECT * FROM hr.Employees;

DESC s_emp;
SELECT * FROM s_emp;

-- s_emp 테이블의 employee_idㅇ에 UNIQUE INDEX를 걸어봄
CREATE UNIQUE INDEX s_emp_id_pk
ON s_emp (employee_id);

-- 사용자가 가지고 있는 INDEX 확인 
SELECT * FROM USER_INDEXES;
-- 어느 인덱스가 어느 컬럼에 걸려있는지 확인
SELECT * FROM USER_IND_COLUMNS;

-- 어느 인덱스가 어느 컬럼에 걸려있는지 JOIN 해서 알아봄
SELECT t.INDEX_NAME, t.TABLE_NAME, c.COLUMN_NAME, c.COLUMN_POSITION
    FROM USER_INDEXES t
        JOIN USER_IND_COLUMNS c ON t.INDEX_NAME = c.INDEX_NAME
    WHERE t.TABLE_NAME = 's_EMP';
    
--------------
-- SEQUENCE --
--------------
SELECT * FROM author;

-- 새로운 레코드를 추가 겹치지 않는 유일한 PK가 필요
INSERT INTO author (author_id, author_name)
VALUES (
    (SELECT MAX(author_id) +1 FROM author),
    '이문열');
    
SELECT * FROM author;
ROLLBACK;

-- 순차 객체 SEQUENCE
CREATE SEQUENCE seq_author_id
START WITH 4
INCREMENT BY 1
MAXVALUE 1000000;

-- pk는 SEQUENCE 객체로부터 생성
INSERT INTO author(author_id, author_name, author_desc)
VALUES(seq_author_id.NEXTVAL,'스티븐 킹', '쇼생크 탈출');

SELECT * FROM author;

SELECT seq_author_id.CURRVAL FROM dual;

-- 새 시퀀스 생성
CREATE SEQUENCE my_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10;
    
    SELECT my_seq.NEXTVAL FROM dual;    -- 다음 시퀀스 추출 가상 컬럼
    SELECT my_seq.CURRVAL FROm dual;    -- 시퀀스의 현재 상태
    
-- 시퀀스 수정
ALTER SEQUENCE my_seq
    INCREMENT BY 2
    MAXVALUE 1000000;
    
    SELECT my_seq.CURRVAL FROM dual;
    SELECT my_seq.NEXTVAL FROM dual;
    
-- 시퀀스를 위한 DICTIONARY
SELECT * FROM USER_SEQUENCES;

SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'SEQUENCE';

-- 시퀀스 삭제 
DROP SEQUENCE my_seq;

SELECT * FROM USER_SEQUENCES;

-- BOOK 테이블 pk의 현재 값 확인
SELECT max(book_id) FROM book;

CREATE SEQUENCE seq_book_id
    START WITH 3
    INCREMENT BY 1
    MAXVALUE 1000000
    NOCACHE;
    