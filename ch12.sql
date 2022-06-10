-- 1. ������ �޿� ��հ� ����� �޿� ���̸� ���ϴ� �並 �����Ͻÿ�.
-- 1) �� �̸��� SAL_GAP_VIEW_BY_JOB�� �ϼ���.
-- 2) ���� ���� ����̸��� �������̵�, ������ �޿� ��հ� ����޿��� ����
-- 3) ������ �޿� ����� �������̺��� �ִ� �޿��� �ּ� �޿��� ����� �ǹ�
Create or replace view sal_gap_view_by_job
as select
    e.first_name as name,
    a.job_id,
    round(a.avg_sal - e.salary,0) as job_sal_gap
    from employees e
    join (select job_id, (max_salary + min_salary)/2 as avg_sal from jobs) a
    on a.job_id = e.job_id;

--2. 2. ��� ����� ���̵�� �̸� �׸��� �μ� �̸��� ���� �̸��� ����� �� �ִ� �並 ����
create or replace view emp_view
as select
        e.employee_id as id,
        e.first_name as name,
        d.department_name as department,
        j.job_title as job
    from employees e
    left join departments d on e.department_id = d.department_id
    join jobs j on e.job_id = j.job_id;

--ch13��
-- 1. �Խ����� �Խñ� ��ȣ�� ���� �������� �����ϼ���.
-- ����1) ������ �̸��� BBS_SEQ���� �մϴ�.
-- ����2) �Խñ� ��ȣ�� 1�� �����մϴ�.
-- ����3) �������� 1���� �����ϸ� �ִ밪�� ����X
-- ����4) ĳ�� ������ 20���̸�, ����Ŭ�� ���ġ �ʽ��ϴ�.
create sequence bbss_seq
    increment by 1
    start with 1
    cache 20
    nocycle;

--2.����� �޿� ���޾����� �˻��� �ϰ� �ͽ��ϴ�. 
-- �������� �ε����� �����ϼ���. �ε����̸��� idx_emp_realsal�Դϴ�. 
-- ���� ������ SALARY + SALARY *COMMISSION_PCT�Դϴ�.
create index idx_emps_realsal
on emps(coalesce(salary+salary*commission_pct,salary));

--ch14��
--1)c##foo�� c##bar �� 2���� ����ڸ� �����ϼ���. ��й�ȣ�� a12345�Դϴ�
conn /as sysdba;
create user c##foo IDENTIFIED By a12345;
create user c##bar IDENTIFIED By a12345;

conn /as sysdba;
create role c##manager;
grant create table, create view to c##manager;
grant c##manager to c##foo, c##bar;

-- ����� c##foo�� c##bar���� �α��� ������ �ο��ϱ�
-- ��� ���̺��� �����ϱ� ���� ����� c##foo���� ���Ѥ��� �ο��ϱ�
-- ����� c##foo�� �����Ͽ� c##bar���Ե� ��� ���̺� ���� select ������ �ο��ϰ� ����� ���� ��ȸ�ϱ�
grant create session to c##foo, c##bar;
conn hr/hr;
grant select on employees to c##foo with grant option;
conn c#foo/a12345;
select count(*) from hr.employees; --����ڰ� ��ȸ
grant select on hr.employees to c##bar;
conn c##var.a12345;
select count(*) from hr.employees; -- c##bar ����ڰ� ��ȸ

-- �����c##foo�� c##bar���� �ο��ߴ� hr ������� ������ ȸ��
conn hr/hr;
revoke select on employees from c##foo;
conn /as sysdba;
drop user c##foo;
drop user c##bar;
