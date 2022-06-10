-- 1. 직무별 급여 평균과 사원의 급여 차이를 구하는 뷰를 생성하시오.
-- 1) 뷰 이름은 SAL_GAP_VIEW_BY_JOB로 하세요.
-- 2) 뷰의 열은 사원이름과 직무아이디, 직무별 급여 평균과 사원급여의 차이
-- 3) 직무별 급여 평균은 직무테이블의 최대 급여와 최소 급여의 평균을 의미
Create or replace view sal_gap_view_by_job
as select
    e.first_name as name,
    a.job_id,
    round(a.avg_sal - e.salary,0) as job_sal_gap
    from employees e
    join (select job_id, (max_salary + min_salary)/2 as avg_sal from jobs) a
    on a.job_id = e.job_id;

--2. 2. 모든 사원의 아이디와 이름 그리고 부서 이름과 직무 이름을 출력할 수 있는 뷰를 생성
create or replace view emp_view
as select
        e.employee_id as id,
        e.first_name as name,
        d.department_name as department,
        j.job_title as job
    from employees e
    left join departments d on e.department_id = d.department_id
    join jobs j on e.job_id = j.job_id;

--ch13장
-- 1. 게시판의 게시글 번호를 위한 시퀀스를 생성하세요.
-- 조건1) 시퀀스 이름은 BBS_SEQ여야 합니다.
-- 조건2) 게시글 번호는 1씩 증가합니다.
-- 조건3) 시퀀스는 1부터 시작하며 최대값을 설정X
-- 조건4) 캐쉬 개수는 20개이며, 사이클은 허용치 않습니다.
create sequence bbss_seq
    increment by 1
    start with 1
    cache 20
    nocycle;

--2.사원의 급여 지급액으로 검색을 하고 싶습니다. 
-- 연봉으로 인덱스를 생성하세요. 인덱스이름은 idx_emp_realsal입니다. 
-- 연봉 계산식은 SALARY + SALARY *COMMISSION_PCT입니다.
create index idx_emps_realsal
on emps(coalesce(salary+salary*commission_pct,salary));

--ch14장
--1)c##foo와 c##bar 총 2명의 사용자를 생성하세요. 비밀번호는 a12345입니다
conn /as sysdba;
create user c##foo IDENTIFIED By a12345;
create user c##bar IDENTIFIED By a12345;

conn /as sysdba;
create role c##manager;
grant create table, create view to c##manager;
grant c##manager to c##foo, c##bar;

-- 사용자 c##foo와 c##bar에게 로그인 권한을 부여하기
-- 사원 테이블을 질의하기 위해 사용자 c##foo에게 권한ㅇ르 부여하기
-- 사용자 c##foo로 접속하여 c##bar에게도 사원 테이블에 대한 select 권한을 부여하고 사원의 수를 조회하기
grant create session to c##foo, c##bar;
conn hr/hr;
grant select on employees to c##foo with grant option;
conn c#foo/a12345;
select count(*) from hr.employees; --사용자가 조회
grant select on hr.employees to c##bar;
conn c##var.a12345;
select count(*) from hr.employees; -- c##bar 사용자가 조회

-- 사용자c##foo와 c##bar에게 부여했던 hr 사용자의 권한을 회수
conn hr/hr;
revoke select on employees from c##foo;
conn /as sysdba;
drop user c##foo;
drop user c##bar;
