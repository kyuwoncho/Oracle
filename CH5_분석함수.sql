--5��.
-- 1. ��� ����� �μ���ȣ, �̸�, �޿�, �μ��� �޿� ������ ����ϼ���. �ߺ����� ����� ������ �������� �����ϴ�. 
-- �� ����� ���� ���� ����� �޿��� �߰��Ͽ� ����ϼ���.
select department_id,first_name,salary,
RANK() over(partition by department_id order by salary DESC) sal_rank,
LAG(salary,1,0) over (partition by department_id order by salary DESC) as prev_salary,
first_value(salary) OVER (PARTITION	BY department_id order BY salary DESC ROWs 1 PRECEDING)	AS	prev_salary2
from employees
order by 1;

--2.170�� ����� �����ȣ ���� ����� �̸��� ����ϼ���./�ٽ�
select frist_name
from(
    select employee_id,LAG(first_name,1,0) over(order by employee_id) as frist_name
    from employees
    )
    where employee_id = 170;
    
--3.��� ����� �޿� ������ ����ϼ���./�ٽ�
--����� �� �� ����� �ٹ��ϴ� �μ��� ���� ���� �޿�, �׸��� ���� ū �޿�, 
--�׸��� �μ����� �޿��� ���� ���� ������� �޿� ���̸� ����ϼ���.
select employee_id,department_id,
first_value(salary) over(partition by department_id order by salary
rows between unbounded preceding and unbounded following) as lower_sal,
salary as MY_SAL,
last_value(salary) over(partition by department_id order by salary
rows between unbounded preceding and unbounded following) as higer_sal,
last_value(salary) over(partition by department_id order by salary
rows between unbounded preceding and unbounded following)-salary as diff_Sal
from employees;
