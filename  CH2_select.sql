--2장.
--1. 모든 사원의 사원번호, 이름, 입사일, 급여를 출력하세요. 
select employee_id,first_name,hire_date,salary
from employees;

--2. 모든 사원의 이름과 성을 붙여 출력하세요. 열 별칭은 name으로 하세요. 
select first_name||' '||last_name as name
from employees;

--3. 50번 부서 사원의 모든 정보를 출력하세요. 
select *
from employees
where department_id = '50';

--4. 50번 부서 사원의 이름, 부서번호, 직무아이디를 출력하세요. 
select first_name,department_id,employee_id
from employees
where department_id = '50';

--5. 모든 사원의 이름, 급여 그리고 300달러 인상된 급여를 출력하세요
select first_name,salary,salary+300
from employees;

--6. 급여가 10000보다 큰 사원의 이름과 급여를 출력하세요. 
select first_name,salary
from employees
where salary >= 10000;

--7. 보너스를 받는 사원의 이름과 직무, 보너스율을 출력하세요. 
select first_name,job_id,commission_pct
from employees
where commission_pct is not null;

--8. 2003년도 입사한 사원의 이름과 입사일 그리고 급여를 출력하세요. (BETWEEN 연산자 사용)
select first_name,hire_date,salary
from employees
where hire_date between '03/01/01' and '03/12/31';

--9. 2003년도 입사한 사원의 이름과 입사일 그리고 급여를 출력하세요. (LIKE 연산자 사용)
select first_name,salary,hire_date
from employees
where To_char(hire_date,'YY') LIKE '03';
--10. 모든 사원의 이름과 급여를 급여가 많은 사원부터 적은 사원 순으로 출력하세요. 
select first_name,salary
from employees
order by salary DESC;

--11. 위 질의를 60번 부서의 사원에 대해서만 질의하세요. 
select first_name,salary
from employees
where department_id = '60'
order by salary DESC;

--12. 직무아이디가 IT_PROG 이거나, SA_MAN인 사원의 이름과 직무아이디를 출력하세요. 
select first_name,job_id
from employees
where job_id = 'IT_PROG' or job_id = 'SA_MAN';

--13. Steven King 사원의 정보를 "Steven King 사원의 급여는 24000달러입니다" 형식으로 출력하세요. 
select first_name||' '||last_name||'사원의 급여는 '||salary||'달러 입니다.'
from employees
where first_name = 'Steven' and last_name LIKE 'King';

--14. 매니저(MAN) 직무에 해당하는 사원의 이름과 직무아이디를 출력하세요. >> = vs %
select first_name,job_id
from employees
where job_id LIKE '%MAN%';

--15. 매니저(MAN) 직무에 해당하는 사원의 이름과 직무아이디를 직무아이디 순서대로 출력하세요
select first_name,job_id
from employees
where job_id LIKE '%MAN%'
order by job_id;