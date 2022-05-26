--8장 데이터 조작(DML)
--연습
create table emp1 as select * from employees;
select count(*) from emp1;

create table emp2 as select * from employees where 1=2;
select count(8) from emp2;
--테이블 구조 확인
DESC departments;
--삽입
INSERT INTO departments	
VALUES (280,'Data Analytics',null,1700);

insert into departments
    (department_id,department_name,location_id)
VALUES
    (280,'Data Analytics',1700);
    
select *
from departments
where department_id=280;

rollback;

create table managers as
select employee_id,frist_name,job_id,salary,hire_date
from employees
where 1=2;

insert into managers
(employee_id,first_name,job_id,salary,hire_date)
select employee_id,first_name,job_id,salary,hire_date
from employees
where job_id LIKE '%MAN';

create table emps as select * from employees;

alter table emps
add ( constraint emps_emp_id_pk primary key (employee_id), 
constraint emps_manager_id_fk FOREIGN KEY (manager_id)
references emps(employee_id)
);
--103번 사원의 사원 아이디와 이름그리고 급여 출력하기
select employee_id, first_name,salary
from emps
where employee_id =103;
--103번 사원의 급여를 10% 인상하기
update emps
set salary=salary*1.1
where employee_id = 103;
--변경된 행을 확인하기
select employee_id, first_name,salary
from emps
where employee_id = 103;

commit;

select employee_id, first_name, job_id, salary, manager_id
from emps
where employee_id IN (108,190);

--update 구문 작성
update emps
set (job_id,salary,manager_id) = (select job_id, salary, manager_id
from emps where employee_id = 108)
where employee_id = 109;

--delete
alter table emps
add (constraint emps_emp_id_pk 
    primary key (employee_id), 
    constraint emps_manager_id_kr 
    FOREIGN KEY (manager_id)
    references emps(employee_id)
);

-- EMPS_IT 테이블과 EMPLOYEES 테이블 병합.
-- 직무가 IT_PROG 인 사원들의 정보를 EMPLOYEES 테이블에서 조회
-- EMPS_IT 테이블과 병합
--EMPS_IT 테이블에 사원 아이디가 같튼ㅇ 사원 정보가 존재할 떄는 기존 정보를 EMPLOYEES 테이블의 내용으로 UPDATE
--EMPS_IT 테이블에 없는 행들은 INSERT 수행
create table emps_it as select * from employees where 1=2;

merge into emp_it a
    USING (select * from employees where job_id = 'IT_PROG') b
    ON (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
    a.phone_number = b.phone_number,
    a.hire_date = b.hire_date,
    j.job_id = b.job_id,
    a.salary = b.salary,
    a.commission_pct = b.commission_pct,
    a.manager_id = b.manager_id,
    a.department_id = b.department_id
when not matched then
    insert values
    (b.employee_id, b.first_name, b.last_name, b.email,
    b.phone_number, b.hire_date, b.job_id, b.salary,
    b.commission_pct, b.manager_id, b.department_id);
    

--연습문제
--1. EMPLOYEES 테이블에 있는 데이터를 열 단위로 나눠 저장하고 싶습니다. 
-- 사원번호, 사원이름, 급여, 보너스율을 저장하기 위한 구조와 데이터를 갖는 테이블을 
--EMP_SALARY_INFO이라는 이름으로 생성하세요. 
-- 그리고 사원번호, 사원이름, 입사일, 부서번호를 저장하기 위한 
--구조와 데이터를 갖는 테이블을 EMP_HIREDATE_INFO라는 이름으로 생성하세요
create table emp_salary_info AS
    select employee_id, first_name, salary, commission_pct
    from employees;
create table emp_hiredate_info as
    select employee_id, first_name, hire_date, department_id
    from employees;
--2. EMPLOYEES 테이블에 다음 데이터를 추가하세요
--사원번호 : 1030/성 : KilDong/이름 : Hong/이메일 : HONGKD/전화번호 : 010-1234-5678
-- 입사일 : 2018/03/20 / 직무아이디 : IT_PROG/급여 : 6000/보너스율 : 0.2/매니저번호 : 103/부서번호 : 60
insert into employees
values(1030,'kilDong','Hong','HONGKD','010-1234-5678','18/03/20','IT_PROG',6000,0.2,103,60);
--3.1030번 사원의 급여를 10% 인상시키세요.
update employees set salary=salary*1.1
where employee_id = 1030;
--4. 1030번 사원의 정보를 삭제하세요.
delete from employees
where employee_id = 1030;
--5. 사원테이블을 이용하여, 2001~2003년에 근무한 사원들의 employee_id,first_name,hire_data, 연도를 출력
--조건1) 각 연도에 해당하는 테이블을 생성. 속성은 사원사이디,이름,입사일,연도. 데이터 크기 지정. 테이블 이름은 emp_yr_연도
--조건2) 연도 열은 입사일에서 연도만 출력. 열 이름은 'yr'이고, 4자리 문자로 표현
--조건3) INSERT ALL 구문으로 작성

--테이블 생성
create table emp_yr_2001(
    employee_id NUMBER(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
create TABLE emp_yr_2002(
    employee_id NUMBER(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
create TABLE emp_yr_2003(
    employee_id NUMBER(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
--행 삽입
insert all
when To_char(hire_date, 'RRRR') = '2001' then
 into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
when To_char(hire_date, 'RRRR') = '2002' then
 into emp_yr_2002 values (employee_id,first_name, hire_date, yr)
when To_char(hire_date, 'RRRR') = '2003' then
 into emp_yr_2003 values (employee_id,first_name, hire_date, yr)
select employee_id, first_name, hire_date, to_Char(hire_date,'RRRR')as yr FROM employees;
--check
select * from emp_yr_2001;
select * from emp_yr_2002;
select * from emp_yr_2003;

--6. 문제5의 조건3을 비교연산자를 사용하여 INSERT FIRST 구문으로 작성하기
insert first
 when hire_date <= '01/12/31' then
    into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
 when hire_date <= '02/12/31' then
    into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
 when hire_date <= '03/12/31' then
    into emp_yr_2001 values (employee_id,first_name, hire_date, yr)
    
select employee_id, first_name, hire_date, to_Char(hire_date,'YYYY') as yr from employees;

--7. employees 테이블의 사원들 정보를 아래의 두 테이블에 나눠 저장하기
--조건1) emp_personal_info 테이블에는 employee_id, first_name, last_name, email, phone_number가 저장
--조건2)emp_office_info 테이블에 employee_id, hire_date, salary, commission_pct, manager_id, department_id를 저장
create table emp_personal_info as
    select employee_id, first_name, last_name, email,phone_number
    from employees
    where 1=2;
create table emp_office_info as
    select employee_id,hire_date,salary,commission_pct,manager_id, department_id
    from employees
    where 1=2;
insert all 
    into emp_personal_info
     values (employee_id, first_name, last_name,email,phone_number)
    into emp_office_info
     values(employee_id, hire_date,salary, commission_pct, manager_id, department_id)
    select * from employees;
--check
select * from emp_personal_info;
select * from emp_office_info;

--8. employees 테이블의 사원들 정보를 아래의 두 테이블에 나눠서 저장
--조건1) 보너스가 있는 사원들의 정보는 emp_comm 테이블에 저장
--조건2) 보너스가 없는 사원들의 정보는 emp_nocomm 테이블에 저장
create table emp_comm as select * from employees where 1=2;
create table emp_nocomm as select * from employees where 1=2;
insert all
    when commission_pct IS NULL THEN
        into emp_comm
        values (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,
        commission_pct, manager_id, department_id)
    when commission_pct IS NOT NULL THEN
        into emp_comm
        values ( employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,
        commission_pct, manager_id, department_id)
    select * from employees;