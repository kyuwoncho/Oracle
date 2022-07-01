--4��
--1. ������ �޿� ����� ����ϼ���
select job_id, avg(salary) as average
from employees
group by job_id;

--2.�μ��� ����� ���� ����ϼ���.
select department_id,count(*)
from employees
group by department_id;

--3.�μ���, ������ ����� ���� ���� ����ϼ���.
select department_id,job_id,count(*)
from employees
group by department_id,job_id;

--4.�μ��� �޿� ǥ�������� ����ϼ���.
select department_id,round(stddev(salary),2)
from employees
group by department_id;

--5.����� ���� 4���̻��� �μ��� ���̵�� ����� ���� ����ϼ���.
select department_id,count(*)
from employees
group by department_id
having count(department_id)>=4;

--6. 50���μ��� ������ ����� ���� ����ϼ���.
select job_id,count(*)
from employees
where department_id = '50'
group by job_id;

--7. 50�� �μ����� ������ ����� ���� 10�������� �������̵�� ����� ���� ����ϼ���.
select job_id,count(*)
from employees
where department_id='50'
group by job_id
having count(job_id)<10;

--8.������ �� �Ի�⵵ ���� ������� �޿� ��հ� ������� ����ϼ���. 
--����1) �Ի�⵵�� ���� ������ �����ϼ���.
select to_char(hire_date,'YYYY') as �Ի�⵵, round(avg(salary),0), count(*)
from employees
group by to_char(hire_date,'YYYY')
order by 1;

--9. ������ �� �Ի�⵵�� �Ի�� ���� ������� �޿� ��հ� ������� ����ϼ���. 
--����1) �Ի�⵵�� ���� ������ ������ ����, �Ի�⵵�� ���ٸ� �Ի���� �������� �����ϼ���. 
--����2) �Ի�⵵�� �������� �޿���հ� ������� �� �հ踦 ���ϼ���.
select to_char(hire_date,'YYYY') as hire_year,to_char(hire_date,'MM') as hire_month,
round(avg(salary),0) as avgerage,count(*)
from employees
group by rollup(to_char(hire_date,'YYYY'), to_char(hire_date,'MM'))
order by 1;

--10. ������ �� �Ի�⵵�� �Ի�� ���� ������� �޿� ��հ� ������� ����ϼ���. 
--����1) �Ի�⵵�� ���� ������ ������ ����, �Ի�⵵�� ���ٸ� �Ի���� �������� �����ϼ���.
--����2) �Ի�⵵�� �Ի���� �������� �޿���հ� ������� �� �հ踦 ���ϼ���. 
--��, �Ի�⵵�� �հ�� ���հ衯, �Ի���� �հ�� ���հ衯, �Ի���� ��ü �հ�� ���հ衯�� ����ϼ���.
select to_char(hire_date,'YYYY') as hire_year,
decode(grouping_id(to_char(hire_date,'MM')),1,'�Ұ�',to_char(hire_date,'MM')) as hire_month,
round(avg(salary),0) as avgerage,count(*)
from employees
group by rollup(to_char(hire_date,'YYYY'), to_char(hire_date,'MM'))
order by 1;

--11. ������ �� �Ի�⵵�� �Ի�� ���� ������� �޿� ��հ� ������� ����ϼ���
--����1) �Ի�⵵�� ���� ������ ������ ����, �Ի�⵵�� ���ٸ� �Ի���� �������� �����ϼ���.
--����2) �Ի�⵵�� �Ի���� �������� �޿���հ� ������� �� �հ踦 ���ϼ���. 
--��, �Ի�⵵�� �հ�� ���Ұ衯, �Ի���� �հ�� ���հ衯�� ����ϼ���.
--����3) 2�� �̻��� ���� ���� ���踦 Ȯ���ϴ� GROUPING_ID ���� ����ϼ���. �� ���� �̸��� ��GID���Դϴ�.
select NVL(to_char(hire_date,'YYYY'),decode(grouping(to_char(hire_date,'YYYY')),1,'�հ�')) as hire_year,
NVL(to_char(hire_date,'MM'),decode(grouping(to_char(hire_date,'MM')),1,'�Ұ�')) as hire_month,
round(avg(salary),0) as avgerage,count(*)
from employees
group by cube(to_char(hire_date,'YYYY'), to_char(hire_date,'MM'))
order by 1,2;