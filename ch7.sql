--��������
--1. 20�� �μ��� �ٹ��ϴ� ������� �Ŵ����� �Ŵ����� ���� ������� ������ ����ϼ���.
select employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary
from employees
where manager_id in (select manager_id
    from employees
    where department_id = 20);

--2. ���� ���� �޿��� ���� ����� �̸� ���
select first_name
from(
select first_name, salary
from employees
order by salary DESC)
where rownum=1;

--3. �޿� ������(��������) 3������ 5������ ����ϼ���.(rownum �̿�)
select rnum, first_name, salary
from(
    select rownum as rnum,first_name, salary
    from(
        select first_name, salary
        from employees
        order by salary DESC
        )
    )
where rnum between 3 and 5;

--4. . �μ��� �μ��� ����̻� �޿��� �޴� ����� �μ���ȣ, �̸�, �޿�, ��ձ޿��� ����ϼ���
select department_id, first_name,salary,
(select round(avg(salary)) from employees c where c.department_id = a.department_id) as AVG_SAL
from employees a
where salary >= (select avg(salary) 
                from employees b 
                where b.department_id = a.department_id)
order by 1;



