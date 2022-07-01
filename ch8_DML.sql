--ch8 DML
-- 103�� ����� ��� ���̵�� �̸� �׸��� �޿��� 10%�λ�
update emps
set salary=salary *1.1
where employee_id = 103;

-- ����� ���� Ȯ��
select employee_id,first_name,salary
from emps
where employee_id = 103;

--���������� ���� �� ���� ������ �ۼ��ϱ� ���� ���� �� ������ ���
select employee_id,first_name, job_id, salary, manaer_id
from employees
where employee_id in (108,109);

update emps
    set (job_id,salary,manager_id) =  
    (select job_id,salary,manager_id 
    from emps 
    where employee_id=108)
where employee_id = 109;

--delete����
create table emps as select * from employees;

alter table emps
add (constraint emps_emp_id_pk primary key (employee_id),
    constraint emps_manager_id_fk foreign key(manager_id)
    references emps(employee_id)
    );
    
--�� ����
delete from empls
where employee_id = 104;
--�μ� �̸��� shipping�� ��� ��� ���� ����
delete from emps
where department_id = (select department_id from depts where department_name = 'Shipping');
-- Ȯ��
COMMIT;

--employees ���̺�� ������ ����, �����ʹ� ����X �ӽ� ���̺� EMPS_IT ����
--IT_PROG ������ ���� ���� ������ �����ϱ� ���� ���̺�
create table emps_it as select * from employees where 1=2;

insert into emps_it(employee_id,first_name,last_name,email,hire_date,job_id)
values (105,'David','kim','DAVIDIM','06/03/04','IT_PROG');

-- EMPS_IT�� EMPLOYEES ���̺� ����
-- ������ IT_PROG�� ������� ������ employees ���̺��� ��ȸ + EMPS_IT ���̺�� ����
-- EMPS_IT ���̺� ��� ���̵� ���� ��� ������ ������ ���� ���� ������ EMPLOYEES ���̺��� �������� update
-- emps_it ���̺� ���� ����� insert����
MERGE	INTO	emps_it	a
 		USING	(SELECT	*	FROM	employees	WHERE	job_id='IT_PROG')	b
 		ON	(a.employee_id	=	b.employee_id)
 WHEN	MATCHED	THEN
 		UPDATE	SET
 				a.phone_number	=	b.phone_number,
 				a.hire_date	=	b.hire_date,
 				a.job_id	=	b.job_id,
 				a.salary	=	b.salary,
 				a.commission_pct	=	b.commission_pct,
 				a.manager_id	=	b.manager_id,
 				a.department_id	=	b.department_id
WHEN	NOT	MATCHED	THEN
 		INSERT	VALUES	
 			(b.employee_id,	b.first_name,	b.last_name,	b.email,	
 				b.phone_number,	b.hire_date,	b.job_id,	b.salary,	
 				b.commission_pct,	b.manager_id,	b.department_id);
--���� Ȯ��
SELECT * FROM emps_it;
-- insert all�� �̿��Ͽ� ���� �ٸ� ���̺� ������ ����

insert all
    into emp1 
        values(300,	'Kildong', 'Hong', 'KHONG', '011.624.7902',	TO_DATE('2015-05-11','YYYY-MM-DD'), 'IT_PROG', 6000, null, 100, 90)
    into emp2
        values(400,'Kilseo','Hong','KSHONG','011.3402.7902', TO_DATE('2015-06-20', 'YYYY-MM-DD'),'IT_PROG', 5500, null, 100, 90)
select * from dual;
-- employees ���̺� �ִ� �����͸� �� ������ ������ ����
-- 1) EMP_SALARY ���̺��� �����ȣ, �����̸�, �޿� �׸��� ���ʽ��� ����
create table emp_salary as
select employee_id, first_name, salary, commission_pct
from employees
where 1=2;
-- 2) EMP_HIRE_DATE ���̺��� �����ȣ, ��� �̸�, �Ի��� �׸��� �μ���ȣ�� ����
create table emp_hire_date  as
    select employee_id first_name, hire_date,department_id
    from employees
    where 1=2;
--3) EMP_SALARY�� EMP_HIRE_DATE ���̺� ������ ����
insert all
into emp_salary VALUES(employee_id, first_name,salary, commission_pct)
into emp_hire_date VALUES(employee_id, first_name, hire_date,department_id)
select * from employees;
--Ȯ���ϱ�
select * from emp_salary;
select * from emp_hire_date;
create table emp_10 as select * from employees where 1=2;
--�μ���ȣ=10/�������=EMP_10/�μ���ȣ=20 > EMP_20 ���̺� ����
create table em_10 as select * from employees;
create table em_20 as select * from employees;
insert all
    when department_id = 10 then
        into em_10 values(employee_id, first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
    when department_id = 20 then
        into em_20 values(employee_id, first_name, last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
select * from employees;
--Ȯ���ϱ�
select * from em_20;
--condidtional insert first
-- ù��° when ������ ������ ������ ��� ���� when ���� ����X
create table emp_sal5000 as select employee_id, first_name,salary from employees where 1=2;
create table emp_sal10000 as select employee_id, first_name,salary from employees where 1=2;
create table emp_sal15000 as select employee_id, first_name,salary from employees where 1=2;
create table emp_sal2000 as select employee_id, first_name, salary from employees where 1=2;
create table emp_sal25000 as select employee_id, first_name, salary from employees where 1=2;

--��������
--1. EMPLOYEES ���̺� �ִ� �����͸� �� ������ ���� �����ϰ� �ͽ��ϴ�. 
-- �����ȣ, ����̸�, �޿�, ���ʽ����� �����ϱ� ���� ������ �����͸� ���� ���̺��� EMP_SALARY_INFO�̶�� �̸����� ����
--�����ȣ, ����̸�, �Ի���, �μ���ȣ�� �����ϱ� ���� ������ �����͸� ���� ���̺��� EMP_HIREDATE_INFO��� �̸����� ����
create table SALARY_INFO as select employee_id, first_name, salary, commission_pct from employees;
create table HIREDATE_INFO as select employee_id, first_name, hire_date,department_id from employees;
--CHECK
select * from SALARY_INFO;
select * from HIREDATE_INFO;

--2. EMPLOYEES ���̺� ���� �����͸� �߰��ϼ���
--(�׸�)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
insert into employees
values(1030,'KilDong','hong','HONGKD','010-1234-5678','2018/03/20','IT_PROG',6000,0.2,103,60);
--check
select * from employees where first_name LIKE 'KilDong';

--3. 1030�� ����� �޿��� 10% �λ��Ű����.
update employees set salary= salary*1.1
where employee_id = '1030';
--check
select * from employees where employee_id = '1030';

--4.1030�� ����� ������ �����ϼ���
delete from employees where employee_id = '1030';

--5. ������̺��� �̿��Ͽ�, 2001�⿡ �ٹ��� ������� ������̵�, �̸�, �Ի���, ������ ���
create table yr_2001 as select employee_id, first_name,hire_date,to_char(hire_date,'YYYY') as YEAR from employees where to_char(hire_date,'YYYY') = '2001';
--check
select * from yr_2001;
--������ ũ�� ���� + insert all�� ����Ͽ� 2002�⵵ �ֱ�
create table yr_2002
    (employee_id number(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
--����
insert into yr_2002 (employee_id,first_name,hire_date,yr)
select employee_id,first_name,hire_date,to_char(hire_date,'YYYY') as yr from employees where to_char(hire_date,'YYYY') ='2002';
--check
select * from yr_2002;

--6. Employees ���̺��� ����� ������ �Ʒ��� �� ���̺� ���� �����ϼ���. >>>>>>????????????????????????????????????????
-- ����1) emp_personal_info ���̺��� employee_id, first_name, last_name, email,phone_number�� ����ǵ��� �ϼ���. 
-- ����2) emp_office_info ���̺��� employee_id, hire_date, salary, commission_pct,manager_id, department_id�� ����ǵ��� �ϼ���.
create table personal_info as select employee_id, first_name, last_name, email,phone_number from employees where 1=2;
create table office_info as select employee_id, hire_date, salary, commission_pct,manager_id, department_id from employees where 1=2;

insert all
    into personal_info values(employee_id,first_name,last_name,email,phone_number)
    into office_info values(employee_id,	hire_date,	salary,	commission_pct,	manager_id,	department_id)
select * from employees;
--8. Employees ���̺��� ����� ������ �Ʒ��� �� ���̺� ���� �����ϼ���. 
--����1) ���ʽ��� �ִ� ������� ������ emp_comm ���̺� �����ϼ���. 
--����2) ���ʽ��� ���� ������� ������ emp_nocomm ���̺� �����ϼ���.
CREATE	TABLE	emp_comm	AS	SELECT	*	FROM	employees	WHERE	1=2;
CREATE	TABLE	emp_nocomm	AS	SELECT	*	FROM	employees	WHERE	1=2;
--�� �ֱ�
insert all 
when commission_pct is null then 
into emp_comm values(employee_id, first_name, last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
when commission_pct is not null then 
into emp_nocomm 
values(employee_id, first_name, last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
select * from employees;


--ch 9 transection
-- 1. �ǽ��� ���� EMPLOYEES ���̺��� �纻 ���̺��� �����ϼ���. �纻 ���̺��� �̸��� EMP_TEMP�Դϴ�.
create table EMP_TEMP as select * from employees;
-- 2. EMP_TEMP ���̺��� 20�� �μ� ����� ������ �����ϰ� �ѹ� ������ �����ϼ���. �ѹ� ������ �̸��� SVPNT_DEL_20���� �մϴ�.
delete from EMP_TEMP where department_id = 20;
savepoint SVPNT_DEL_20;
-- 3. 50���μ��� ����� ������ �����ϰ� �ѹ� ������ �����ϼ���. �ѹ� ������ �̸��� SVPNT_DEL_50���� �մϴ�.
delete from EMP_TEMP where department_id = 50;
SAVEPOINT	SVPNT_DEL_50;
-- 4. 60�� �μ��� ��� ������ �����ϼ���. 
delete from EMP_TEMP where department_id = 60;
--5. ���� 60�� �μ��� ��� ������ �����ߴ� �۾��� ����ϼ���. �� ���� �۾��� ����ϸ� �ȵ˴ϴ�.
rollback to savepoint SVPNT_DEL_50;

select * from EMP_TEMP where department_id = 60;

--10��
--1.1. �̸� ����� ��Ģ
create table "TEST" (c1 VARCHAR2(1));
insert into "TEST" VALUES('X');
--CREATE TABLE
--DEPTNO(����2�ڸ�),DNAME(���� 14�ڸ�),LOC 3��(���� 13�ڸ�)�� ���� ����
create table dept(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13) );
-- ���̺� ���� DESCRIBE ��ɾ� ����Ͽ� ���̺��� ������ Ȯ��
DESCRIBE dept
--DDL �������� ���̺� ���� > �ڵ����� Ŀ��
create table emp(
    empno number(4,0),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4,0),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2,0)
);

--���������� ����� ���̺� ����
-- SELECT �� ������ ���̺��� ������ �����ϰ� �����͵� ����
create table em2 as select * from employees;
select count(*) from em2;

--���̺� ������ ����
--alter tabel
create table emp_dept50
as select employee_id,first_name,salary*12 as ann_sal, hire_date
from employees
where department_id = 50;

--add ���� �̿��Ͽ� ���ο� ���� �߰�
alter table emp_dept50
add (job varchar2(10));

--Ȯ��
select * from emp_dept50;

-- �� ����
--frist_name ���� ũ�⸦ ����
alter table emp_dept50
modify (first_name VARCHAR2(30));
--�� ũ�� ���̱�
alter table emp_dept50
modify (first_name varchar2(10));

--job_id �� ����
alter table emp_dept50
drop column job;

desc emp_dept50;

--�� �̸� ����
alter table emp_dept50
rename column job to job_id;

-- set unused�ɼǰ� drop unused �ɼ�
alter table emp_Dept50 set unused (first_name);
--check
desc emp_dept50;

--drop unused columns : ���̺��� ���X ������ ������ ��ũ ������ ȸ���� ��� �� ��ɹ� ���
-- ���̺��� ���X ���� ������ ���� �߻�X ��ɹ� ��ȯ
alter table emp_dept50 drop unused columns;
-- set unused ������ user_unused_col_tabs ��� ��ųʸ� �信 ����Ǿ� ����
--set used ����X �ϰ��ð��� set unused�� ����� �� X ����>�ϰ��ð� ���Ŀ��� drop unused columns ����� �����ؼ� �ش� ���� ����
-- alter table ������ �ǵ��� �� X, alter table ������ �����Ű�� ���� Ʈ������� commit

-- ��ü �̸� ����
rename emp_dept50 to employees_dept50;
-- ���̺� ����
create table emp_dept50
as 
    select employee_id, first_name,salary*12 as ann_sal, hire_date
    from employees
    where department_id = 50;

-- add�� �̿��ؼ� ���ο� �� �߰�
alter table emp_dept50
add(job VARCHAR2(10));
--check
select * from emp_dept50;
--���̺� ����
drop table employees_dept50;
-- ���̺� ��ü ����
truncate table emp2;
drop table member;
--��������
--1. ȸ�� ������ �����ϴ� ���̺�(member)�� �����Ͻÿ�
create table member 
   (userid VARCHAR2(15) NOT NULL,
   name VARCHAR2(20) NOT NULL, 
   password VARCHAR2(20)NOT NULL, 
   phone VARCHAR2(15), 
   email varchar2(100));
--check
select * from member;

--2. ����ھ��̵�, �̸�, ��й�ȣ, ��ȭ��ȣ, �̸����� �����ϴ� ������ �ۼ��ϼ���. 
--- user123, �����, a1234567890, 011-234-5678, user@user.com
INSERT INTO 
    member(userid, name, password, phone, email) 
    values('user123','�����','a1234567890', '011-234-5678', 'user@user.com');
--check
select * from member;
--3. ����ھ��̵� user123�� ������� ��� ������ ��ȸ�ϼ���.
select * from member where userid = 'user123';

--4. ����ھ��̵� user123�� ������� �̸�, ��й�ȣ, ��ȭ��ȣ, �̸����� �����ϼ���. 
-- ȫ�浿, a1234, 011-222-3333, user@user.co.kr
update member
    set name = 'ȫ�浿', password='a123', phone = '011-222-3333', email = 'user@user.co.kr'
    where userid = 'user123';
--check
select * from member;

--5. ����ھ��̵� user123�̰� ��й�ȣ�� a1234�� ȸ���� ������ �����ϼ���.
delete from member
    where userid = 'user123' and password = 'a1234';

--6. ȸ�� ������ �����ϴ� ���̺�(member)�� ��� ���� �����ϼ���. TRUNCATE ������ �̿��ϼ���.
truncate table member;

--7. ȸ�� ������ �����ϴ� ���̺�(member)�� �����ϼ���.
drop table member;

--ch 11�������� constraints
--1. ���������̶�?
--user_constraints ������ ��ųʸ����� ���̺� ���ǵ� ���������� �� ���ִ�.
select * from user_constraints;
--���� ������ �Ʒ� ���ǿ� �´� ���̺��� �����մϴ�. 
-- �����ȣ, �̸�, �޿�, �μ���ȣ�� �����ϴ� ���̺��� �����ؾ� �մϴ�. 
-- �����ȣ�� PK, �̸��� Not Null, �޿��� 10,000 ����, �μ���ȣ�� departments ���̺��� department_id���� �����ؼ� �����մϴ�. 
-- ���̺� �̸��� �� �̸�, �׸��� ���� Ÿ���� ���Ƿ� �����մϴ�.
create table emp4(
    empno number(4) constraint emp4_empno_pk primary key,
    ename varchar2(10) not null,
    sal number(7,2) constraint emp4_sal_ck check(sal<=10000),
    deptno number(2) constraint emp4_Deptno_dept_deptid_fk references departments(department_id));
--���� ������ �Ʒ� ���ǿ� �´� ���̺��� �����մϴ�. 
-- �����ȣ, �̸�, �޿�, �μ���ȣ�� �����ϴ� ���̺��� �����ؾ� �մϴ�.
-- �����ȣ�� PK, �̸��� NN, �޿��� 10000 ����, �μ���ȣ�� departments ���̺��� �����ؼ� �����մϴ�. 
-- ���̺� �̸��� �� �̸�, �׸��� ���� Ÿ���� ���Ƿ� �����մϴ�.
create table emp5(
    empno number(4),
    ename varchar2(10) not null,
    sal number(7,2),
    deptno number(2),
    constraint emp5_empno_pk primary key(empno),
    constraint emp5_sal_ck check(sal<=10000),
    constraint emp5_Deptno_dept_deptid_fk 
    foreign key (deptno) references departments(department_id));
--2. �������� ����
--primary key ���������� ���̺� ���� �Ǵ� �� �������� ����
-- deptno ���� �⺻Ű(PK)�� ������ ���̺� ����
create table depts(
    deptno number(2),
    dname varchar2(14),
    loc varchar2(13),
    constraint depts_dname_uk unique(dname),
    constraint depts_Deptno_pk primary key(deptno));
-- foreign key ���������� �� or ���̺� �������� �������� ���� �� �� ����.
-- ���� �ܷ�Ű�� ���̺� ���� ���Ǹ� ����Ͽ� ����.

--EMPS ���̺��� DEPTNO������ FOREIGN KEY ���������� ����
--���������� �̸� = EMPS_DEPTS_DEPTNO_FK
create table emps(
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2) not null,
    constraint emps_empno_pk primary key(empno),
    constraint emps_depts_deptno_fk foreign key (deptno)
    references depts(deptno));
-- emps ���̺� �ȿ� ��ȿ�� ������� �̹� �����ؾ� �ϴ� �����ڸ� ��Ÿ���� EMPS ���̺��� MGR ���� ���ؼ� FROEIGN KEY ���������� �߰�
alter table emps
    add constraint emps_mgr_fk
    foreign key(mgr) references emps(empno);
--3. �������� ����
--(�߰�)���� ������ EMPS ���̺� �ȿ� ��ȿ�� ������� �̹� �����ؾ� �ϴ� �����ڸ� ��Ÿ���� EMPS ���̺��� MGR ���� ���ؼ� FOREIGN KEY ���������� �߰��մϴ�.
alter table emps
    add constraint emps_mgr_rk foreign key(mgr) references emps(empno);
--(��ȸ) USER_CONSTRAINTS ������ ��ųʸ��� ���� EMPS ���̺��� ��� �������� ���� ���
select 	constraint_name, constraint_type,status
from USER_CONSTRAINTS
where table_name = 'EMPS';
--(����)  EMPS ���̺��� �������� ���������� ����
alter table depts drop primary key cascade;
--DEPTS ���̺��� PRIMARY KEY ���������� �����ϰ� EMPS.DEPTNO���� ���õ� FOREIGN KEY ���������� ����
alter table depts drop primary key cascade;
--���������� ������ �� emps ���̺� �������� ���
SELECT constraint_name, constraint_type, status
from USER_CONSTRAINTS
where table_name = 'EMPS';
--���� ������ CHECK ���������� ��Ȱ��ȭ�ϰ� �����͸� INSERT �մϴ�. �޿�(SAL��)��
--10000 ���Ͽ��� �ϴ� ���������� ������, ��Ȱ��ȭ�� ���� INSERT �ϸ� 10000���� ū ���� �����ͺ��̽��� ���������� INSERT�� �˴ϴ�.
ALTER TABLE emp4 DISABLE CONSTRAINT	emp4_sal_ck;
insert into emp4 (empno, ename,sal,deptno)
    values(9999,'KING',20000,10);
select * from emp4;
--emps4 table�� sal���� ���� ���������� �ٽ� Ȱ��ȭ �ϴ� ����
--enable validate �������� ���� ����� ���鿡 ���� �������� üũ�� �̷����
-- �տ��� ���������� ��Ȱ��ȭ�ϰ� �Է��� ���� check ���� ������ �������� ���ϹǷ� ���� �߻�
--����� ���������� �˻����� �ʰ� Ȱ��ȭ
alter table emp4
enable novalidate CONSTRAINT emp4_sal_ck;

--��������
--1. ȸ�� ������ �����ϴ� ���̺�(member)�� �����ϼ���. ȸ�� ������ ����� ���̵�(15),
--�̸�(20), ��й�ȣ(20), ��ȭ��ȣ(15), �̸���(100)�� �����ؾ� �մϴ�. ��ȣ ���� ���ڴ� ũ���Դϴ�. 
--ȸ�� ������ �����ϴ� ���̺��� ����� ���̵� PK�� �����ϴ�.
create table member(
    user_id varchar2(15) not null,
    ename varchar2(10) not null,
    password VARCHAR2(15) not null,
    phone VARCHAR2(15),
    email VARCHAR2(15));
alter table member
add constraint member_user_id_pk PRIMARY KEY(user_id)

--2. ���� ���̺� ������ �����ؼ� ���������� �߰��ϼ���. 
-- DEPT ���̺��� DEPTNO ���� ��Ű(primary key) ���̾�� �մϴ�. 
-- ���������� �̸��� pk_dept�� �ϼ���. 
-- EMP ���̺��� EMPNO ���� ��Ű(primary key) ���̾�� �մϴ�. 
-- ���������� �̸��� pk_emp�� �ϼ���. 
-- EMP ���̺��� DEPTNO ���� DEPT ���̺��� DEPTNO ���� �����ϴ� �ܷ�Ű(foreign key)���� �մϴ�. 
-- ���������� �̸��� fk_deptno�� �ϼ���.
create table dept(
    deptno number(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    constraint pk_dept PRIMARY KEY(deptno)    
);
create table emp(
    empno number(4,0),
    ename vcarchar2(10),
    job varchar2(9),
    mgr number(4,0),
    hiredate date,
    sal number(7,2),
    sal number(7,2),
    comm number(7,2),
    deptno number(2,0),
    constraint pk_emp primary key(empno),
    constraint fk_deptno foreign key(deptno) references dept(deptno)
);