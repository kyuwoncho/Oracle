--3��
--1. �̸��Ͽ� lee�� �����ϴ� ����� ��� ������ ����ϼ���.
select employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id
from employees
where EMAIL LIKE '%LEE%';

--2.�Ŵ��� ���̵� 103�� ������� �̸��� �޿�, �������̵� ����ϼ���.
select first_name, salary,job_id
from employees
where manager_id LIKE '%103%';

--3.80�� �μ��� �ٹ��ϸ鼭 ������ SA_MAN�� ����� ������ 20�� �μ��� �ٹ��ϸ鼭 �Ŵ��� ���̵� 100�λ���� ������ ����ϼ���. ������ �ϳ��� ����ؾ� �մϴ�
select *
from employees
where (department_id = '80' AND job_id = 'SA_MAN') or (department_id = '20' and manager_id = 100);

--4. ��� ����� ��ȭ��ȣ�� ###-###-#### �������� ����ϼ���.
select substr(PHONE_NUMBER,1,3)||'-'||substr(PHONE_NUMBER,5,3)||'-'||substr(PHONE_NUMBER,9,4) as phone
from employees;

--5. ������ IT_PROG�� ����� �߿��� �޿��� 5000 �̻��� ������� �̸�(Full Name), �޿� ���޾�, 
--�Ի���(2005-02-15����), �ٹ��� �ϼ��� ����ϼ���. �̸������� �����ϸ�, �̸��� �ִ� 20�ڸ�,
--���� �ڸ��� *�� ä��� �޿� ���޾��� �Ҽ��� 2�ڸ��� ������ �ִ� 8�ڸ�, $ǥ��, ���� �ڸ��� 0���� ä�� ����ϼ���.
select RPAD(first_name||' '||last_name,20,'*') as FULL_NAME, 
To_char(coalesce(salary+salary*commission_pct,salary),'$099,999.00') as salary,
To_Char(hire_date,'YYYY-MM-DD')as HIRE_DAY,
round(sysdate-hire_date) as WORK_DAY
from employees
where job_id = 'IT_PROG' and salary>=5000
order by 1;

--6. 30�� �μ� ����� �̸�(full name)�� �޿�, �Ի���, ������� �ٹ� ���� ���� ����ϼ���. 
--�̸��� �ִ� 20�ڷ� ����ϰ� �̸� �����ʿ� ���� ������ *�� ����ϼ���. 
--�޿��� �󿩱��� �����ϰ� �Ҽ��� 2�ڸ��� ������ �� 8�ڸ��� ����ϰ� ���� �ڸ��� 0���� ä��� ���ڸ����� 
--,(�޸�) ���б�ȣ�� �����ϰ�, �ݾ� �տ� $�� �����ϵ��� ����ϼ���. 
--�Ի����� 2005��03��15�� �������� ����ϼ���. �ٹ� ���� ���� �Ҽ��� ���ϴ� ������ ����ϼ���. 
--�޿��� ū ������� ���� ������ ����ϼ���. 
select RPAD(first_name||' '||last_name,20,'*') as FULL_NAME,
To_char(coalesce(salary+salary*commission_pct,salary),'$099,999.00')as SALARY,
To_char(hire_date,'YYYY"��" MM"��" DD"��"') as HIRE_DATE,
trunc(months_between(sysdate,hire_date)) as  Month
from employees
where department_id = '30'
order by salary DESC;

--7. 80�� �μ��� �ٹ��ϸ鼭 salary�� 10000���� ū ������� �̸��� 
--�޿� ���޾�(salary + salary * commission_pct)�� ����ϼ���. 
--�̸��� Full Name���� ����ϸ� 17�ڸ��� ����ϼ���. ���� �ڸ��� *�� ä�켼��.
--�޿��� �Ҽ��� 2�ڸ��� ������ ��7�ڸ��� ����ϸ�, ���� �ڸ��� 0���� ä�켼��. 
--�ݾ� �տ� $ ǥ�ø� �ϸ� �޿� ������ �����ϼ���.
select rpad(first_name||' '||last_name,17,'*') as Full_name,
to_char(coalesce(salary+salary*commission_pct,salary),'$99,999.00') as salary
from employees
where department_id = '80' and salary>10000
order by salary DESC;

--8. 60���μ� ����� �̸��� ���� ���ڸ� �������� ������� �ٹ��� �ٹ������� 5����, 10����, 15������ ǥ���ϼ���. 
--5��~ 9�� �ٹ��� ����� 5������ ǥ���մϴ�. �������� ��Ÿ�� ǥ���մϴ�. 
--�ٹ������� �ٹ�������/12�� ����մϴ�.
select first_name,
decode(trunc(trunc(months_between(SYSDATE,hire_date)/12)/5),1,'5����',2,'10����',3,'15����','��Ÿ') as month
from employees
where department_id = 60;

--9.Lex�� �Ի����� 1000��° �Ǵ� ����? 
select hire_date+1000
from employees
where first_name LIKe '%Lex%';

--10. 5���� �Ի��� ����� �̸��� �Ի����� ����ϼ���
select first_name,hire_date
from employees
where To_Char(hire_date,'MM') LIKE '05';

--11. ������ �� �̸��� �޿��� ����ϼ���. 
--����1) �Ի��� ������ ����� ���� ���弼��. �� ���� �̸��� ��year���̰�, ��(�Ի�⵵)�� �Ի硱�������� ����ϼ���. 
--����2) �Ի��� ������ ����� ���� ���弼��. �� ���� �̸��� ��day���̰�, �����ϡ��������� ����ϼ���. 
--����3) �Ի����� 2010�� ������ ����� �޿��� 10%, 2005�� ������ ����� �޿��� 5%�� �λ��ϼ���. 
        --�� ���� �̸��� ��INCREASING_SALARY���Դϴ�. 
 --����4) INCREASING_SALARY ���� ������ �տ� ��$����ȣ�� �ٰ�, �� �ڸ����� �޸�(,)�� �־��ּ���.
 select first_name, salary, To_char(hire_date,'YYYY"�� �Ի�"')as YEAR,
 to_char(hire_date,'day') as day,
 Case when to_char(hire_date,'YYYY')> '2010' then to_char((salary+salary*0.1),'$999,999')
 when to_char(hire_date,'YYYY')> '2005' then to_char((salary+salary*0.05),'$999,999')
 else to_char(salary,'$999,999')
 END as INCREASING_SALARY
 from employees;
 
-- 12. ����� �̸�, �޿�, �Ի�⵵, �λ�� �޿��� ����ϼ���. 
--����1) �Ի��� ������ ����ϼ���. �� ���� �̸��� ��year���̰�, ��(�Ի�⵵)�� �Ի硱�������� ����ϼ���. 
--����2) �Ի����� 2010���� ����� �޿��� 10%, 2005���� ����� �޿��� 5%�� �λ��ϼ���. 
--�� ���� �̸��� ��INCREASING_SALARY2���Դϴ�
select first_name,salary,to_char(hire_date,'YYYY"�� �Ի�"') as YEAR,
decode(to_Char(hire_date,'YYYY'),2010,salary*1.1,'2005',salary*1.05,salary) as INCREASEING_SALARY2
from employees;

--13. ��ġ ��� �� ��(sate)���� ���� null�̸� ���� ���̵� ����ϼ���.
select country_id,NVL(state_province,country_id) as state
from locations;