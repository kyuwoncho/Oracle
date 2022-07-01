--4장
--1. 직무별 급여 평균을 출력하세요
select job_id, avg(salary) as average
from employees
group by job_id;

--2.부서별 사원의 수를 출력하세요.
select department_id,count(*)
from employees
group by department_id;

--3.부서별, 직무별 사원의 수를 각각 출력하세요.
select department_id,job_id,count(*)
from employees
group by department_id,job_id;

--4.부서별 급여 표준편차를 출력하세요.
select department_id,round(stddev(salary),2)
from employees
group by department_id;

--5.사원의 수가 4명이상인 부서의 아이디와 사원의 수를 출력하세요.
select department_id,count(*)
from employees
group by department_id
having count(department_id)>=4;

--6. 50번부서의 직무별 사원의 수를 출력하세요.
select job_id,count(*)
from employees
where department_id = '50'
group by job_id;

--7. 50번 부서에서 직무별 사원의 수가 10명이하인 직무아이디와 사원의 수를 출력하세요.
select job_id,count(*)
from employees
where department_id='50'
group by job_id
having count(job_id)<10;

--8.사원목록 중 입사년도 별로 사원들의 급여 평균과 사원수를 출력하세요. 
--조건1) 입사년도가 빠른 순으로 정렬하세요.
select to_char(hire_date,'YYYY') as 입사년도, round(avg(salary),0), count(*)
from employees
group by to_char(hire_date,'YYYY')
order by 1;

--9. 사원목록 중 입사년도와 입사월 별로 사원들의 급여 평균과 사원수를 출력하세요. 
--조건1) 입사년도가 빠른 순으로 정렬한 이후, 입사년도가 같다면 입사월을 기준으로 정렬하세요. 
--조건2) 입사년도를 기준으로 급여평균과 사원수의 총 합계를 구하세요.
select to_char(hire_date,'YYYY') as hire_year,to_char(hire_date,'MM') as hire_month,
round(avg(salary),0) as avgerage,count(*)
from employees
group by rollup(to_char(hire_date,'YYYY'), to_char(hire_date,'MM'))
order by 1;

--10. 사원목록 중 입사년도와 입사월 별로 사원들의 급여 평균과 사원수를 출력하세요. 
--조건1) 입사년도가 빠른 순으로 정렬한 이후, 입사년도가 같다면 입사월을 기준으로 정렬하세요.
--조건2) 입사년도와 입사월을 기준으로 급여평균과 사원수의 총 합계를 구하세요. 
--단, 입사년도의 합계는 ‘합계’, 입사월의 합계는 ‘합계’, 입사월의 전체 합계는 ‘합계’로 출력하세요.
select to_char(hire_date,'YYYY') as hire_year,
decode(grouping_id(to_char(hire_date,'MM')),1,'소계',to_char(hire_date,'MM')) as hire_month,
round(avg(salary),0) as avgerage,count(*)
from employees
group by rollup(to_char(hire_date,'YYYY'), to_char(hire_date,'MM'))
order by 1;

--11. 사원목록 중 입사년도와 입사월 별로 사원들의 급여 평균과 사원수를 출력하세요
--조건1) 입사년도가 빠른 순으로 정렬한 이후, 입사년도가 같다면 입사월을 기준으로 정렬하세요.
--조건2) 입사년도와 입사월을 기준으로 급여평균과 사원수의 총 합계를 구하세요. 
--단, 입사년도의 합계는 ‘소계’, 입사월의 합계는 ‘합계’로 출력하세요.
--조건3) 2개 이상의 열에 대한 집계를 확인하는 GROUPING_ID 값을 출력하세요. 이 열의 이름은 ‘GID’입니다.
select NVL(to_char(hire_date,'YYYY'),decode(grouping(to_char(hire_date,'YYYY')),1,'합계')) as hire_year,
NVL(to_char(hire_date,'MM'),decode(grouping(to_char(hire_date,'MM')),1,'소계')) as hire_month,
round(avg(salary),0) as avgerage,count(*)
from employees
group by cube(to_char(hire_date,'YYYY'), to_char(hire_date,'MM'))
order by 1,2;