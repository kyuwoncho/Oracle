--�����ϱ�

--103�� ����� �̸��� �μ� �̸� ���
select e.first_name as NAME, d.department_name AS department
from employees e
join departments d
on e.department_id = d.department_id
where employee_id = 103;

-- 103�� ����� �̸��� �μ� �̸�, �׸��� �ּ� ���
select e.first_name as name,d.department_name as department,
l.street_address || ', '|| l.city || ', '||l.state_province as address
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where employee_id = 103;

--103�� ����� �̸��� �μ� �̸�
select e.first_name as name, d.department_name as department
from employees e
join departments d
on e.department_id = d.department_id and employee_id = 103;

--���� ��� �ٸ� �ڵ�
select e.first_name as name, d.department_name as department, 
l.street_address || ', '||l.city||', '||l.state_province as address
from employees e
join departments d
on e.department_id = d.department_id and employee_id =103
join locations l
on d.location_id = l.location_id;

select e.first_name as name, d.department_name as department,
l.street_address || ', '||l.city||', '||l.state_province as address
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id=l.location_id and employee_id=103;

--��� ����� ���� ���� �̷��� ���� ������ ���
select e.employee_id, e.first_name, e.hire_date,
j.start_date,j.end_date, j.job_id,j.department_id
from employees e
left outer join job_history j
on e.employee_id = j.employee_id
order by e.employee_id;

--��������
--Using table - ENPLOYEES/DEPARTMENTS/LOCATEION/JOBS
--1. join ����� �̸��� �μ��̸�, �μ���ġ(city)
--ver.ORACLE JOIN
select e.first_name,d.department_name,l.city
from employees e,departments d,locations l
where first_name = 'John'
and e.department_id = d.department_id
and d.location_id = l.location_id;
--ver �Ƚ� ����:
select e.first_name, d.department_name, l.city
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id=l.location_id
where first_name='John';

--2. 103�� ����� �����ȣ, �̸�, �޿�, �Ŵ����̸�, �Ŵ��� �μ��̸��� ����ϼ���(ver �Ƚ�����)
select e.employee_id, e.first_name,	e.salary, m.first_name,	
d.department_name
from employees e
join employees m on e.manager_id = m.employee_id
join departments d on m.department_id = d.department_id
where e.employee_id = 103;

--3. 90�� ������� ���, �̸�, �޿�, �Ŵ����̸�, �Ŵ����޿�, �Ŵ����μ��̸��� ���
--ver ORCLE
select e.employee_id, e.first_name,e.salary,m.first_name,m.salary,d.department_id
from employees e, employees m,departments d
where e.manager_id = m.employee_id(+)
and m.department_id = d.department_id(+)
and e.department_id =90;
--ver �Ƚ� ����
select e.employee_id, e.first_name,e.salary,m.first_name,m.salary,d.department_id
from employees e
left join employees m on e.manager_id = m.employee_id
left join departments d on m.department_id = d.department_id
where e.department_id=90;


--4.103������� �ٹ��ϴ� ���ô� ? ver �Ƚ�����
select e.employee_id, l.city
from employees e
join departments d on d.department_id = d.department_id
join locations l on d.location_id = l.location_id
where e.employee_id = 103;

--5. �����ȣ�� 103�� ����� �μ���ġ(city)�� �Ŵ����� �����̸�(job_title)�� ����Ͻÿ� ver�Ƚ�����
select l.city as "department Location", j.job_title as "Manager's JOb"
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join employees m on e.manager_id = m.employee_id
join jobs j on m.job_id = j.job_id
where e.employee_id = 103;

--6. ����� ��� ������ ��ȸ�ϴ� �������� �ۼ��Ͻÿ�
-- ����� �μ���ȣ�� �μ��̸�����, �������̵�� �����̸����� �Ŵ��� ���̵�� �Ŵ��� �̸����� ����ϼ���
select e.employee_id, e.first_name, e.last_name, e.email,e.phone_number, e.hire_date, j.job_title,
e.salary,e.commission_pct,m.first_name as MANAGER_FIRST_NAME, m.last_name as MANAGER_LAST_NAME,
d.department_name
from employees e
left join departments d on e.department_id = d.department_id
join jobs j on e.job_id=j.job_id
left join employees m on e.manager_id = m.employee_id;

--7. ������ �ִ� ������?
select employee_id, 
e.first_name, --employees.first_name�� ������ ����
e.department_id,
d.department_id
from employees e, departments d
where e.department_id = d.department_id;