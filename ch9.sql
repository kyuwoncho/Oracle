--8�� ������ ����(DML)
--����
create table emp1 as select * from employees;
select count(*) from emp1;

create table emp2 as select * from employees where 1=2;
select count(8) from emp2;
--���̺� ���� Ȯ��
DESC departments;
--����
INSERT INTO departments	
VALUES (280,'Data Analytics',null,1700);

insert into departments
    (department_id,department_name,location_id)
VALUES
    (280,'Data Analytics',1700);
    
select *
from departments
where department_id=280;

rollback;

create table managers as
select employee_id,frist_name,job_id,salary,hire_date
from employees
where 1=2;

insert into managers
(employee_id,first_name,job_id,salary,hire_date)
select employee_id,first_name,job_id,salary,hire_date
from employees
where job_id LIKE '%MAN';

create table emps as select * from employees;

alter table emps
add ( constraint emps_emp_id_pk primary key (employee_id), 
constraint emps_manager_id_fk FOREIGN KEY (manager_id)
references emps(employee_id)
);
--103�� ����� ��� ���̵�� �̸��׸��� �޿� ����ϱ�
select employee_id, first_name,salary
from emps
where employee_id =103;
--103�� ����� �޿��� 10% �λ��ϱ�
update emps
set salary=salary*1.1
where employee_id = 103;
--����� ���� Ȯ���ϱ�
select employee_id, first_name,salary
from emps
where employee_id = 103;

commit;

select employee_id, first_name, job_id, salary, manager_id
from emps
where employee_id IN (108,190);

--update ���� �ۼ�
update emps
set (job_id,salary,manager_id) = (select job_id, salary, manager_id
from emps where employee_id = 108)
where employee_id = 109;

--delete
alter table emps
add (constraint emps_emp_id_pk 
    primary key (employee_id), 
    constraint emps_manager_id_kr 
    FOREIGN KEY (manager_id)
    references emps(employee_id)
);

-- EMPS_IT ���̺�� EMPLOYEES ���̺� ����.
-- ������ IT_PROG �� ������� ������ EMPLOYEES ���̺��� ��ȸ
-- EMPS_IT ���̺�� ����
--EMPS_IT ���̺� ��� ���̵� ��ư�� ��� ������ ������ ���� ���� ������ EMPLOYEES ���̺��� �������� UPDATE
--EMPS_IT ���̺� ���� ����� INSERT ����
create table emps_it as select * from employees where 1=2;

merge into emp_it a
    USING (select * from employees where job_id = 'IT_PROG') b
    ON (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
    a.phone_number = b.phone_number,
    a.hire_date = b.hire_date,
    j.job_id = b.job_id,
    a.salary = b.salary,
    a.commission_pct = b.commission_pct,
    a.manager_id = b.manager_id,
    a.department_id = b.department_id
when not matched then
    insert values
    (b.employee_id, b.first_name, b.last_name, b.email,
    b.phone_number, b.hire_date, b.job_id, b.salary,
    b.commission_pct, b.manager_id, b.department_id);
    

--��������
--1. EMPLOYEES ���̺� �ִ� �����͸� �� ������ ���� �����ϰ� �ͽ��ϴ�. 
-- �����ȣ, ����̸�, �޿�, ���ʽ����� �����ϱ� ���� ������ �����͸� ���� ���̺��� 
--EMP_SALARY_INFO�̶�� �̸����� �����ϼ���. 
-- �׸��� �����ȣ, ����̸�, �Ի���, �μ���ȣ�� �����ϱ� ���� 
--������ �����͸� ���� ���̺��� EMP_HIREDATE_INFO��� �̸����� �����ϼ���
create table emp_salary_info AS
    select employee_id, first_name, salary, commission_pct
    from employees;
create table emp_hiredate_info as
    select employee_id, first_name, hire_date, department_id
    from employees;
--2. EMPLOYEES ���̺� ���� �����͸� �߰��ϼ���
--�����ȣ : 1030/�� : KilDong/�̸� : Hong/�̸��� : HONGKD/��ȭ��ȣ : 010-1234-5678
-- �Ի��� : 2018/03/20 / �������̵� : IT_PROG/�޿� : 6000/���ʽ��� : 0.2/�Ŵ�����ȣ : 103/�μ���ȣ : 60
insert into employees
values(1030,'kilDong','Hong','HONGKD','010-1234-5678','18/03/20','IT_PROG',6000,0.2,103,60);
--3.1030�� ����� �޿��� 10% �λ��Ű����.
update employees set salary=salary*1.1
where employee_id = 1030;
--4. 1030�� ����� ������ �����ϼ���.
delete from employees
where employee_id = 1030;
--5. ������̺��� �̿��Ͽ�, 2001~2003�⿡ �ٹ��� ������� employee_id,first_name,hire_data, ������ ���
--����1) �� ������ �ش��ϴ� ���̺��� ����. �Ӽ��� ������̵�,�̸�,�Ի���,����. ������ ũ�� ����. ���̺� �̸��� emp_yr_����
--����2) ���� ���� �Ի��Ͽ��� ������ ���. �� �̸��� 'yr'�̰�, 4�ڸ� ���ڷ� ǥ��
--����3) INSERT ALL �������� �ۼ�

--���̺� ����
create table emp_yr_2001(
    employee_id NUMBER(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
create TABLE emp_yr_2002(
    employee_id NUMBER(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
create TABLE emp_yr_2003(
    employee_id NUMBER(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
--�� ����
insert all
when To_char(hire_date, 'RRRR') = '2001' then
 into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
when To_char(hire_date, 'RRRR') = '2002' then
 into emp_yr_2002 values (employee_id,first_name, hire_date, yr)
when To_char(hire_date, 'RRRR') = '2003' then
 into emp_yr_2003 values (employee_id,first_name, hire_date, yr)
select employee_id, first_name, hire_date, to_Char(hire_date,'RRRR')as yr FROM employees;
--check
select * from emp_yr_2001;
select * from emp_yr_2002;
select * from emp_yr_2003;

--6. ����5�� ����3�� �񱳿����ڸ� ����Ͽ� INSERT FIRST �������� �ۼ��ϱ�
insert first
 when hire_date <= '01/12/31' then
    into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
 when hire_date <= '02/12/31' then
    into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
 when hire_date <= '03/12/31' then
    into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
    
select employee_id, first_name, hire_date, to_Char(hire_date,'YYYY') as yr from employees;

--7. employees ���̺��� ����� ������ �Ʒ��� �� ���̺� ���� �����ϱ�
--����1) emp_personal_info ���̺��� employee_id, first_name, last_name, email, phone_number�� ����
--����2)emp_office_info ���̺� employee_id, hire_date, salary, commission_pct, manager_id, department_id�� ����
create table emp_personal_info as
    select employee_id, first_name, last_name, email,phone_number
    from employees
    where 1=2;
create table emp_office_info as
    select employee_id,hire_date,salary,commission_pct,manager_id, department_id
    from employees
    where 1=2;
insert all 
    into emp_personal_info
     values (employee_id, first_name, last_name,email,phone_number)
    into emp_office_info
     values(employee_id, hire_date,salary, commission_pct, manager_id, department_id)
    select * from employees;
--check
select * from emp_personal_info;
select * from emp_office_info;

--8. employees ���̺��� ����� ������ �Ʒ��� �� ���̺� ������ ����
--����1) ���ʽ��� �ִ� ������� ������ emp_comm ���̺� ����
--����2) ���ʽ��� ���� ������� ������ emp_nocomm ���̺� ����
create table emp_comm as select * from employees where 1=2;
create table emp_nocomm as select * from employees where 1=2;
insert all
    when commission_pct IS NULL THEN
        into emp_comm
        values (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,
        commission_pct, manager_id, department_id)
    when commission_pct IS NOT NULL THEN
        into emp_comm
        values ( employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,
        commission_pct, manager_id, department_id)
    select * from employees;