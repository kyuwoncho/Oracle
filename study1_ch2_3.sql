--1장.
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

--2장
--1. 이메일에 lee를 포함하는 사원의 모든 정보를 출력하세요.
select employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id
from employees
where EMAIL LIKE '%LEE%';

--2.매니저 아이디가 103인 사원들의 이름과 급여, 직무아이디를 출력하세요.
select first_name, salary,job_id
from employees
where manager_id LIKE '%103%';

--3.80번 부서에 근무하면서 직무가 SA_MAN인 사원의 정보와 20번 부서에 근무하면서 매니저 아이디가 100인사원의 정보를 출력하세요. 쿼리문 하나로 출력해야 합니다
select *
from employees
where (department_id = '80' AND job_id = 'SA_MAN') or (department_id = '20' and manager_id = 100);

--4. 모든 사원의 전화번호를 ###-###-#### 형식으로 출력하세요.
select substr(PHONE_NUMBER,1,3)||'-'||substr(PHONE_NUMBER,5,3)||'-'||substr(PHONE_NUMBER,9,4) as phone
from employees;
--[다시풀기]
--5. 직무가 IT_PROG인 사원들 중에서 급여가 5000 이상인 사원들의 이름(Full Name), 급여 지급액, 
--입사일(2005-02-15형식), 근무한 일수를 출력하세요. 이름순으로 정렬하며, 이름은 최대 20자리,
--남는 자리는 *로 채우고 급여 지급액은 소수점 2자리를 포함한 최대 8자리, $표시, 남는 자리는 0으로 채워 출력하세요.
select RPAD(first_name||' '||last_name,20,'*') as FULL_NAME, 
To_char(coalesce(salary+salary*commission_pct,salary),'$099,999.00') as salary,
To_Char(hire_date,'YYYY-MM-DD')as HIRE_DAY,
round(sysdate-hire_date) as WORK_DAY
from employees
where job_id = 'IT_PROG' and salary>=5000
order by 1;
--[다시풀기]
--6. 30번 부서 사원의 이름(full name)과 급여, 입사일, 현재까지 근무 개월 수를 출력하세요. 
--이름은 최대 20자로 출력하고 이름 오른쪽에 남는 공백을 *로 출력하세요. 
--급여는 상여금을 포함하고 소수점 2자리를 포함한 총 8자리로 출력하고 남은 자리는 0으로 채우며 세자리마다 
--,(콤마) 구분기호를 포함하고, 금액 앞에 $를 포함하도록 출력하세요. 
--입사일은 2005년03월15일 형식으로 출력하세요. 근무 개월 수는 소수점 이하는 버리고 출력하세요. 
--급여가 큰 사원부터 작은 순서로 출력하세요. 
select RPAD(first_name||' '||last_name,20,'*') as FULL_NAME,
To_char(coalesce(salary+salary*commission_pct,salary),'$099,999.00')as SALARY,
To_char(hire_date,'YYYY"년" MM"월" DD"일"') as HIRE_DATE,
trunc(months_between(sysdate,hire_date)) as  Month
from employees
where department_id = '30'
order by salary DESC;

--7. 80번 부서에 근무하면서 salary가 10000보다 큰 사원들의 이름과 
--급여 지급액(salary + salary * commission_pct)을 출력하세요. 
--이름은 Full Name으로 출력하며 17자리로 출력하세요. 남은 자리는 *로 채우세요.
--급여는 소수점 2자리를 포함한 총7자리로 출력하며, 남은 자리는 0으로 채우세요. 
--금액 앞에 $ 표시를 하며 급여 순으로 정렬하세요.
select rpad(first_name||' '||last_name,17,'*') as Full_name,
to_char(coalesce(salary+salary*commission_pct,salary),'$99,999.00') as salary
from employees
where department_id = '80' and salary>10000
order by salary DESC;

--[다시풀기]
--8. 60번부서 사원의 이름과 현재 일자를 기준으로 현재까지 근무한 근무년차를 5년차, 10년차, 15년차로 표시하세요. 
--5년~ 9년 근무한 사원은 5년차로 표시합니다. 나머지는 기타로 표시합니다. 
--근무년차는 근무개월수/12로 계산합니다.
select first_name,
decode(trunc(trunc(months_between(SYSDATE,hire_date)/12)/5),1,'5년차',2,'10년차',3,'15년차','기타') as month
from employees
where department_id = 60;

--9.Lex가 입사한지 1000일째 되는 날은? 
select hire_date+1000
from employees
where first_name LIKe '%Lex%';

--10. 5월에 입사한 사원의 이름과 입사일을 출력하세요
select first_name,hire_date
from employees
where To_Char(hire_date,'MM') LIKE '05';

--[다시풀기]-case when으로
--11. 사원목록 중 이름과 급여를 출력하세요. 
--조건1) 입사한 연도를 출력한 열을 만드세요. 이 열의 이름은 ‘year’이고, “(입사년도)년 입사”형식으로 출력하세요. 
--조건2) 입사한 요일을 출력한 열을 만드세요. 이 열의 이름은 ‘day’이고, “요일”형식으로 출력하세요. 
--조건3) 입사일이 2010년 이후인 사원은 급여를 10%, 2005년 이후인 사원은 급여를 5%를 인상하세요. 
        --이 열의 이름은 ‘INCREASING_SALARY’입니다. 
 --조건4) INCREASING_SALARY 열의 형식은 앞에 ‘$’기호가 붙고, 세 자리마다 콤마(,)를 넣어주세요.
 select first_name, salary, To_char(hire_date,'YYYY"년 입사"')as YEAR,
 to_char(hire_date,'day') as day,
 Case when to_char(hire_date,'YYYY')> '2010' then to_char((salary+salary*0.1),'$999,999')
 when to_char(hire_date,'YYYY')> '2005' then to_char((salary+salary*0.05),'$999,999')
 else to_char(salary,'$999,999')
 END as INCREASING_SALARY
 from employees;
 
 --[다시풀기 -decode로]
-- 12. 사원의 이름, 급여, 입사년도, 인상된 급여를 출력하세요. 
--조건1) 입사한 연도를 출력하세요. 이 열의 이름은 ‘year’이고, “(입사년도)년 입사”형식으로 출력하세요. 
--조건2) 입사일이 2010년인 사원은 급여를 10%, 2005년인 사원은 급여를 5%를 인상하세요. 
--이 열의 이름은 ‘INCREASING_SALARY2’입니다
select first_name,salary,to_char(hire_date,'YYYY"년 입사"') as YEAR,
decode(to_Char(hire_date,'YYYY'),2010,salary*1.1,'2005',salary*1.05,salary) as INCREASEING_SALARY2
from employees;

--13. 위치 목록 중 주(sate)열에 값이 null이면 국가 아이디를 출력하세요.
select country_id,NVL(state_province,country_id) as state
from locations;

