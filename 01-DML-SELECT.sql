-- SQL ������ �ּ�
-- SQL ������ �������� �����ݷ�(;)���� ������. 
-- Ű�����, ���̺��, �÷� ���� ��ҹ��� �������� �ʴ´�. 
-- ���� �������� ���, ��ҹ��ڸ� �����Ѵ�.

-- ���̺� ���� Ȯ�� (DESCRIBE)
DESCRIBE employees;
describe COUNTRIES;
describe departments;
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    age NUMBER,
    major VARCHAR2(100)
    );
    INSERT INTO Students (student_id, name, age, major) VALUES (1, 'ȫ�浿', 20, '��ǻ�Ͱ���');
    INSERT INTO Students (student_id, name, age, major) VALUES (2, '��ö��', 22, '�濵��');
    
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
    -- * : ���̺� ���� ��� �÷� Projection, ���̺� ����ÿ� ������ �������
    SELECT * FROM Employees;
    
    -- Ư�� �÷��� Projection �ϰ��� �ϸ� �� ����� ���
    
    -- Employees ���̺��� first_name, phone_number, hire_date, salary�� ���� �ʹٸ�,
    SELECT first_name, phone_number, hire_date, salary FROM Employees;
    
    -- ����� �̸�, ��, �޿�, ��ȭ��ȣ, �Ի��� ���� ���
    SELECT last_name, first_name, salary, phone_number, hire_date FROM Employees;
    
    -- �������: �⺻���� ��������� ������ �� �ִ�. 
    -- Ư�� ���̺��� ���� �ƴ� �ý������κ��� �����͸� �޾ƿ����� �� ��: dual (�������̺�)
    SELECT 3.14159 * 10 * 10 FROM dual;
    
    -- Ư�� �÷��� ���� ��� ���꿡 ����
    SELECT first_name �̸�, salary ����, salary*12 ����, 100*12 �ǳ���, (salary + 100) *12 �ǳ���_����_�������� FROM Employees;
    
    -- ������ ���� ã��: job_id�� ���ڿ�(VARCHAR2)
    SELECT job_id*12 FROM Employees;
    SELECT * FROM Employees;
    DESC Employees;
    