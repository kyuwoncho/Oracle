--공부하기

--103번 사원의 이름과 부서 이름 출력
select e.first_name as NAME, d.department_name AS department
from employees e
join departments d
on e.department_id = d.department_id
where employee_id = 103;

-- 103번 사원의 이름과 부서 이름, 그리고 주소 출력
select e.first_name as name,d.department_name as department,
l.street_address || ', '|| l.city || ', '||l.state_province as address
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where employee_id = 103;

--103번 사원의 이름과 부서 이름
select e.first_name as name, d.department_name as department
from employees e
join departments d
on e.department_id = d.department_id and employee_id = 103;

--같은 결과 다른 코드
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

--모든 사원에 대해 직무 이력이 없는 정보도 출력
select e.employee_id, e.first_name, e.hire_date,
j.start_date,j.end_date, j.job_id,j.department_id
from employees e
left outer join job_history j
on e.employee_id = j.employee_id
order by e.employee_id;

--연습문제
--Using table - ENPLOYEES/DEPARTMENTS/LOCATEION/JOBS
--1. join 사원의 이름과 부서이름, 부서위치(city)
--ver.ORACLE JOIN
select e.first_name,d.department_name,l.city
from employees e,departments d,locations l
where first_name = 'John'
and e.department_id = d.department_id
and d.location_id = l.location_id;
--ver 안시 조인:
select e.first_name, d.department_name, l.city
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id=l.location_id
where first_name='John';

--2. 103번 사원의 사원번호, 이름, 급여, 매니저이름, 매니저 부서이름을 출력하세요(ver 안시조인)
select e.employee_id, e.first_name,	e.salary, m.first_name,	
d.department_name
from employees e
join employees m on e.manager_id = m.employee_id
join departments d on m.department_id = d.department_id
where e.employee_id = 103;

--3. 90번 사원들의 사번, 이름, 급여, 매니저이름, 매니저급여, 매니저부서이름을 출력
--ver ORCLE
select e.employee_id, e.first_name,e.salary,m.first_name,m.salary,d.department_id
from employees e, employees m,departments d
where e.manager_id = m.employee_id(+)
and m.department_id = d.department_id(+)
and e.department_id =90;
--ver 안시 조인
select e.employee_id, e.first_name,e.salary,m.first_name,m.salary,d.department_id
from employees e
left join employees m on e.manager_id = m.employee_id
left join departments d on m.department_id = d.department_id
where e.department_id=90;


--4.103번사원이 근무하는 도시느 ? ver 안시조인
select e.employee_id, l.city
from employees e
join departments d on d.department_id = d.department_id
join locations l on d.location_id = l.location_id
where e.employee_id = 103;

--5. 사원번호가 103인 사원의 부서위치(city)와 매니저의 직무이름(job_title)을 출력하시오 ver안시조인
select l.city as "department Location", j.job_title as "Manager's JOb"
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join employees m on e.manager_id = m.employee_id
join jobs j on m.job_id = j.job_id
where e.employee_id = 103;

--6. 사원의 모든 정보를 조회하는 쿼리문을 작성하시오
-- 사원의 부서번호는 부서이름으로, 직무아이디는 직무이름으로 매니저 아이디는 매니저 이름으로 출력하세요
select e.employee_id, e.first_name, e.last_name, e.email,e.phone_number, e.hire_date, j.job_title,
e.salary,e.commission_pct,m.first_name as MANAGER_FIRST_NAME, m.last_name as MANAGER_LAST_NAME,
d.department_name
from employees e
left join departments d on e.department_id = d.department_id
join jobs j on e.job_id=j.job_id
left join employees m on e.manager_id = m.employee_id;

--7. 오류가 있는 라인은?
select employee_id, 
e.first_name, --employees.first_name은 오류가 나옴
e.department_id,
d.department_id
from employees e, departments d
where e.department_id = d.department_id;