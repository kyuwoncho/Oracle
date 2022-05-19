--서브쿼리
--1. 20번 부서에 근무하는 사원들의 매니저와 매니저가 같은 사원들의 정보를 출력하세요.
select employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary
from employees
where manager_id in (select manager_id
    from employees
    where department_id = 20);

--2. 가장 많은 급여를 받은 사람의 이름 출력
select first_name
from(
select first_name, salary
from employees
order by salary DESC)
where rownum=1;

--3. 급여 순으로(내림차순) 3위부터 5위까지 출력하세요.(rownum 이용)
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

--4. . 부서별 부서의 평균이상 급여를 받는 사원의 부서번호, 이름, 급여, 평균급여를 출력하세요
select department_id, first_name,salary,
(select round(avg(salary)) from employees c where c.department_id = a.department_id) as AVG_SAL
from employees a
where salary >= (select avg(salary) 
                from employees b 
                where b.department_id = a.department_id)
order by 1;



