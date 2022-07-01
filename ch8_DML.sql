--ch8 DML
-- 103번 사원의 사원 아이디와 이름 그리고 급여를 10%인상
update emps
set salary=salary *1.1
where employee_id = 103;

-- 변경된 행을 확인
select employee_id,first_name,salary
from emps
where employee_id = 103;

--서브쿼리로 다중 열 갱신 구문을 작성하기 전에 변경 전 데이터 출력
select employee_id,first_name, job_id, salary, manaer_id
from employees
where employee_id in (108,109);

update emps
    set (job_id,salary,manager_id) =  
    (select job_id,salary,manager_id 
    from emps 
    where employee_id=108)
where employee_id = 109;

--delete구문
create table emps as select * from employees;

alter table emps
add (constraint emps_emp_id_pk primary key (employee_id),
    constraint emps_manager_id_fk foreign key(manager_id)
    references emps(employee_id)
    );
    
--행 삭제
delete from empls
where employee_id = 104;
--부서 이름이 shipping인 모든 사원 정보 삭제
delete from emps
where department_id = (select department_id from depts where department_name = 'Shipping');
-- 확인
COMMIT;

--employees 테이블과 구조만 같고, 데이터는 포함X 임시 테이블 EMPS_IT 생성
--IT_PROG 직무를 갖는 사우너 정보만 저장하기 위한 테이블
create table emps_it as select * from employees where 1=2;

insert into emps_it(employee_id,first_name,last_name,email,hire_date,job_id)
values (105,'David','kim','DAVIDIM','06/03/04','IT_PROG');

-- EMPS_IT과 EMPLOYEES 테이블 병합
-- 직무가 IT_PROG인 사원들의 정보를 employees 테이블에서 조회 + EMPS_IT 테이블과 병합
-- EMPS_IT 테이블에 사원 아이디가 같은 사원 정보가 존재할 때는 기존 정보들 EMPLOYEES 테이블의 내용으로 update
-- emps_it 테이블에 없는 행들을 insert수행
MERGE	INTO	emps_it	a
 		USING	(SELECT	*	FROM	employees	WHERE	job_id='IT_PROG')	b
 		ON	(a.employee_id	=	b.employee_id)
 WHEN	MATCHED	THEN
 		UPDATE	SET
 				a.phone_number	=	b.phone_number,
 				a.hire_date	=	b.hire_date,
 				a.job_id	=	b.job_id,
 				a.salary	=	b.salary,
 				a.commission_pct	=	b.commission_pct,
 				a.manager_id	=	b.manager_id,
 				a.department_id	=	b.department_id
WHEN	NOT	MATCHED	THEN
 		INSERT	VALUES	
 			(b.employee_id,	b.first_name,	b.last_name,	b.email,	
 				b.phone_number,	b.hire_date,	b.job_id,	b.salary,	
 				b.commission_pct,	b.manager_id,	b.department_id);
--병합 확인
SELECT * FROM emps_it;
-- insert all을 이용하여 각각 다른 테이블에 데이터 저장

insert all
    into emp1 
        values(300,	'Kildong', 'Hong', 'KHONG', '011.624.7902',	TO_DATE('2015-05-11','YYYY-MM-DD'), 'IT_PROG', 6000, null, 100, 90)
    into emp2
        values(400,'Kilseo','Hong','KSHONG','011.3402.7902', TO_DATE('2015-06-20', 'YYYY-MM-DD'),'IT_PROG', 5500, null, 100, 90)
select * from dual;
-- employees 테이블에 있는 데이터를 열 단위로 나누어 저장
-- 1) EMP_SALARY 테이블은 사원번호, 사우너이름, 급여 그리고 보너스를 저장
create table emp_salary as
select employee_id, first_name, salary, commission_pct
from employees
where 1=2;
-- 2) EMP_HIRE_DATE 테이블은 사원번호, 사원 이름, 입사일 그리고 부서번호를 저장
create table emp_hire_date  as
    select employee_id first_name, hire_date,department_id
    from employees
    where 1=2;
--3) EMP_SALARY와 EMP_HIRE_DATE 테이블에 나누어 저장
insert all
into emp_salary VALUES(employee_id, first_name,salary, commission_pct)
into emp_hire_date VALUES(employee_id, first_name, hire_date,department_id)
select * from employees;
--확인하기
select * from emp_salary;
select * from emp_hire_date;
create table emp_10 as select * from employees where 1=2;
--부서번호=10/사원정보=EMP_10/부서번호=20 > EMP_20 테이블에 저장
create table em_10 as select * from employees;
create table em_20 as select * from employees;
insert all
    when department_id = 10 then
        into em_10 values(employee_id, first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
    when department_id = 20 then
        into em_20 values(employee_id, first_name, last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
select * from employees;
--확인하기
select * from em_20;
--condidtional insert first
-- 첫번째 when 절에서 조건을 만족할 경우 다음 when 절은 수행X
create table emp_sal5000 as select employee_id, first_name,salary from employees where 1=2;
create table emp_sal10000 as select employee_id, first_name,salary from employees where 1=2;
create table emp_sal15000 as select employee_id, first_name,salary from employees where 1=2;
create table emp_sal2000 as select employee_id, first_name, salary from employees where 1=2;
create table emp_sal25000 as select employee_id, first_name, salary from employees where 1=2;

--연습문제
--1. EMPLOYEES 테이블에 있는 데이터를 열 단위로 나눠 저장하고 싶습니다. 
-- 사원번호, 사원이름, 급여, 보너스율을 저장하기 위한 구조와 데이터를 갖는 테이블을 EMP_SALARY_INFO이라는 이름으로 생성
--사원번호, 사원이름, 입사일, 부서번호를 저장하기 위한 구조와 데이터를 갖는 테이블을 EMP_HIREDATE_INFO라는 이름으로 생성
create table SALARY_INFO as select employee_id, first_name, salary, commission_pct from employees;
create table HIREDATE_INFO as select employee_id, first_name, hire_date,department_id from employees;
--CHECK
select * from SALARY_INFO;
select * from HIREDATE_INFO;

--2. EMPLOYEES 테이블에 다음 데이터를 추가하세요
--(그림)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
insert into employees
values(1030,'KilDong','hong','HONGKD','010-1234-5678','2018/03/20','IT_PROG',6000,0.2,103,60);
--check
select * from employees where first_name LIKE 'KilDong';

--3. 1030번 사원의 급여를 10% 인상시키세요.
update employees set salary= salary*1.1
where employee_id = '1030';
--check
select * from employees where employee_id = '1030';

--4.1030번 사원의 정보를 삭제하세요
delete from employees where employee_id = '1030';

--5. 사원테이블을 이용하여, 2001년에 근무한 사원들의 사원아이디, 이름, 입사일, 연도를 출력
create table yr_2001 as select employee_id, first_name,hire_date,to_char(hire_date,'YYYY') as YEAR from employees where to_char(hire_date,'YYYY') = '2001';
--check
select * from yr_2001;
--데이터 크기 지정 + insert all을 사용하여 2002년도 넣기
create table yr_2002
    (employee_id number(6,0),
    first_name VARCHAR2(20),
    hire_date DATE,
    yr VARCHAR2(20));
--삽입
insert into yr_2002 (employee_id,first_name,hire_date,yr)
select employee_id,first_name,hire_date,to_char(hire_date,'YYYY') as yr from employees where to_char(hire_date,'YYYY') ='2002';
--check
select * from yr_2002;

--6. Employees 테이블의 사원들 정보를 아래의 두 테이블에 나눠 저장하세요. >>>>>>????????????????????????????????????????
-- 조건1) emp_personal_info 테이블에는 employee_id, first_name, last_name, email,phone_number가 저장되도록 하세요. 
-- 조건2) emp_office_info 테이블에는 employee_id, hire_date, salary, commission_pct,manager_id, department_id가 저장되도록 하세요.
create table personal_info as select employee_id, first_name, last_name, email,phone_number from employees where 1=2;
create table office_info as select employee_id, hire_date, salary, commission_pct,manager_id, department_id from employees where 1=2;

insert all
    into personal_info values(employee_id,first_name,last_name,email,phone_number)
    into office_info values(employee_id,	hire_date,	salary,	commission_pct,	manager_id,	department_id)
select * from employees;
--8. Employees 테이블의 사원들 정보를 아래의 두 테이블에 나눠 저장하세요. 
--조건1) 보너스가 있는 사원들의 정보는 emp_comm 테이블에 저장하세요. 
--조건2) 보너스가 없는 사원들의 정보는 emp_nocomm 테이블에 저장하세요.
CREATE	TABLE	emp_comm	AS	SELECT	*	FROM	employees	WHERE	1=2;
CREATE	TABLE	emp_nocomm	AS	SELECT	*	FROM	employees	WHERE	1=2;
--값 넣기
insert all 
when commission_pct is null then 
into emp_comm values(employee_id, first_name, last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
when commission_pct is not null then 
into emp_nocomm 
values(employee_id, first_name, last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
select * from employees;


--ch 9 transection
-- 1. 실습을 위해 EMPLOYEES 테이블의 사본 테이블을 생성하세요. 사본 테이블의 이름은 EMP_TEMP입니다.
create table EMP_TEMP as select * from employees;
-- 2. EMP_TEMP 테이블에서 20번 부서 사원의 정보를 삭제하고 롤백 지점을 생성하세요. 롤백 지점의 이름은 SVPNT_DEL_20여야 합니다.
delete from EMP_TEMP where department_id = 20;
savepoint SVPNT_DEL_20;
-- 3. 50번부서의 사원의 정보를 삭제하고 롤백 지점을 생성하세요. 롤백 지점의 이름은 SVPNT_DEL_50여야 합니다.
delete from EMP_TEMP where department_id = 50;
SAVEPOINT	SVPNT_DEL_50;
-- 4. 60번 부서의 사원 정보를 삭제하세요. 
delete from EMP_TEMP where department_id = 60;
--5. 앞의 60번 부서의 사원 정보를 삭제했던 작업을 취소하세요. 그 이전 작업은 취소하면 안됩니다.
rollback to savepoint SVPNT_DEL_50;

select * from EMP_TEMP where department_id = 60;

--10장
--1.1. 이름 만드는 규칙
create table "TEST" (c1 VARCHAR2(1));
insert into "TEST" VALUES('X');
--CREATE TABLE
--DEPTNO(숫자2자리),DNAME(문자 14자리),LOC 3개(문자 13자리)의 열을 생성
create table dept(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13) );
-- 테이블 구조 DESCRIBE 명령어 사용하여 테이블의 생성을 확인
DESCRIBE dept
--DDL 문장으로 테이블 생성 > 자동으로 커밋
create table emp(
    empno number(4,0),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4,0),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2,0)
);

--서브쿼리를 사용한 테이블 생성
-- SELECT 한 결과대로 테이블의 구조를 생성하고 데이터도 저장
create table em2 as select * from employees;
select count(*) from em2;

--테이블 구조만 변경
--alter tabel
create table emp_dept50
as select employee_id,first_name,salary*12 as ann_sal, hire_date
from employees
where department_id = 50;

--add 절을 이용하여 새로운 열을 추가
alter table emp_dept50
add (job varchar2(10));

--확인
select * from emp_dept50;

-- 열 수정
--frist_name 열의 크기를 변경
alter table emp_dept50
modify (first_name VARCHAR2(30));
--열 크기 줄이기
alter table emp_dept50
modify (first_name varchar2(10));

--job_id 열 삭제
alter table emp_dept50
drop column job;

desc emp_dept50;

--열 이름 변경
alter table emp_dept50
rename column job to job_id;

-- set unused옵션과 drop unused 옵션
alter table emp_Dept50 set unused (first_name);
--check
desc emp_dept50;

--drop unused columns : 테이블의 사용X 열에서 여분의 디스크 공간을 회수할 경우 이 명령문 사용
-- 테이블에서 사용X 열이 없으면 오류 발생X 명령문 반환
alter table emp_dept50 drop unused columns;
-- set unused 정보는 user_unused_col_tabs 라는 딕셔너리 뷰에 저장되어 있음
--set used 존재X 일과시간에 set unused로 사용할 수 X 지정>일과시간 이후에는 drop unused columns 명령을 실행해서 해당 열을 삭제
-- alter table 구분은 되돌릴 수 X, alter table 구문을 실행시키면 현재 트랜잭션을 commit

-- 객체 이름 변경
rename emp_dept50 to employees_dept50;
-- 테이블 삭제
create table emp_dept50
as 
    select employee_id, first_name,salary*12 as ann_sal, hire_date
    from employees
    where department_id = 50;

-- add절 이용해서 새로운 열 추가
alter table emp_dept50
add(job VARCHAR2(10));
--check
select * from emp_dept50;
--테이블 삭제
drop table employees_dept50;
-- 테이블 전체 삭제
truncate table emp2;
drop table member;
--연습문제
--1. 회원 정보를 저장하는 테이블(member)를 생성하시오
create table member 
   (userid VARCHAR2(15) NOT NULL,
   name VARCHAR2(20) NOT NULL, 
   password VARCHAR2(20)NOT NULL, 
   phone VARCHAR2(15), 
   email varchar2(100));
--check
select * from member;

--2. 사용자아이디, 이름, 비밀번호, 전화번호, 이메일을 저장하는 쿼리를 작성하세요. 
--- user123, 사용자, a1234567890, 011-234-5678, user@user.com
INSERT INTO 
    member(userid, name, password, phone, email) 
    values('user123','사용자','a1234567890', '011-234-5678', 'user@user.com');
--check
select * from member;
--3. 사용자아이디가 user123인 사용자의 모든 정보를 조회하세요.
select * from member where userid = 'user123';

--4. 사용자아이디가 user123인 사용자의 이름, 비밀번호, 전화번호, 이메일을 수정하세요. 
-- 홍길동, a1234, 011-222-3333, user@user.co.kr
update member
    set name = '홍길동', password='a123', phone = '011-222-3333', email = 'user@user.co.kr'
    where userid = 'user123';
--check
select * from member;

--5. 사용자아이디가 user123이고 비밀번호가 a1234인 회원의 정보를 삭제하세요.
delete from member
    where userid = 'user123' and password = 'a1234';

--6. 회원 정보를 저장하는 테이블(member)의 모든 행을 삭제하세요. TRUNCATE 구문을 이용하세요.
truncate table member;

--7. 회원 정보를 저장하는 테이블(member)을 삭제하세요.
drop table member;

--ch 11제약조건 constraints
--1. 제약조건이란?
--user_constraints 데이터 딕셔너리에서 테이블에 정의된 제약조건을 볼 수있다.
select * from user_constraints;
--다음 구문은 아래 조건에 맞는 테이블을 생성합니다. 
-- 사원번호, 이름, 급여, 부서번호를 저장하는 테이블을 생성해야 합니다. 
-- 사원번호는 PK, 이름은 Not Null, 급여는 10,000 이하, 부서번호는 departments 테이블의 department_id열을 참조해서 저장합니다. 
-- 테이블 이름과 열 이름, 그리고 열의 타입은 임의로 구성합니다.
create table emp4(
    empno number(4) constraint emp4_empno_pk primary key,
    ename varchar2(10) not null,
    sal number(7,2) constraint emp4_sal_ck check(sal<=10000),
    deptno number(2) constraint emp4_Deptno_dept_deptid_fk references departments(department_id));
--다음 구문은 아래 조건에 맞는 테이블을 생성합니다. 
-- 사원번호, 이름, 급여, 부서번호를 저장하는 테이블을 생성해야 합니다.
-- 사원번호는 PK, 이름은 NN, 급여는 10000 이하, 부서번호는 departments 테이블을 참조해서 저장합니다. 
-- 테이블 이름과 열 이름, 그리고 열의 타입은 임의로 구성합니다.
create table emp5(
    empno number(4),
    ename varchar2(10) not null,
    sal number(7,2),
    deptno number(2),
    constraint emp5_empno_pk primary key(empno),
    constraint emp5_sal_ck check(sal<=10000),
    constraint emp5_Deptno_dept_deptid_fk 
    foreign key (deptno) references departments(department_id));
--2. 제약조건 종류
--primary key 제약조건을 테이블 레벨 또는 열 레벨에서 정의
-- deptno 열을 기본키(PK)로 가지는 테이블 생성
create table depts(
    deptno number(2),
    dname varchar2(14),
    loc varchar2(13),
    constraint depts_dname_uk unique(dname),
    constraint depts_Deptno_pk primary key(deptno));
-- foreign key 제약조건은 열 or 테이블 제약조건 레벨에서 정의 될 수 잇음.
-- 조합 외래키는 테이블 레벨 정의를 사용하여 생성.

--EMPS 테이블의 DEPTNO열에서 FOREIGN KEY 제약조건을 정의
--제약조건의 이름 = EMPS_DEPTS_DEPTNO_FK
create table emps(
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2) not null,
    constraint emps_empno_pk primary key(empno),
    constraint emps_depts_deptno_fk foreign key (deptno)
    references depts(deptno));
-- emps 테이블 안에 유효한 사원으로 이미 존재해야 하는 관리자를 나타내는 EMPS 테이블의 MGR 열에 대해서 FROEIGN KEY 제약조건을 추가
alter table emps
    add constraint emps_mgr_fk
    foreign key(mgr) references emps(empno);
--3. 제약조건 관리
--(추가)다음 구문은 EMPS 테이블 안에 유효한 사원으로 이미 존재해야 하는 관리자를 나타내는 EMPS 테이블의 MGR 열에 대해서 FOREIGN KEY 제약조건을 추가합니다.
alter table emps
    add constraint emps_mgr_rk foreign key(mgr) references emps(empno);
--(조회) USER_CONSTRAINTS 데이터 딕셔너리를 통해 EMPS 테이블의 모든 제약조건 정보 출력
select 	constraint_name, constraint_type,status
from USER_CONSTRAINTS
where table_name = 'EMPS';
--(삭제)  EMPS 테이블에서 관리자의 제약조건을 제거
alter table depts drop primary key cascade;
--DEPTS 테이블에서 PRIMARY KEY 제약조건을 제거하고 EMPS.DEPTNO열에 관련된 FOREIGN KEY 제약조건을 삭제
alter table depts drop primary key cascade;
--제약조건이 삭제된 후 emps 테이블 제약조건 출력
SELECT constraint_name, constraint_type, status
from USER_CONSTRAINTS
where table_name = 'EMPS';
--다음 구문은 CHECK 제약조건을 비활성화하고 데이터를 INSERT 합니다. 급여(SAL열)는
--10000 이하여야 하는 제약조건이 있지만, 비활성화한 다음 INSERT 하면 10000보다 큰 값도 데이터베이스에 정상적으로 INSERT가 됩니다.
ALTER TABLE emp4 DISABLE CONSTRAINT	emp4_sal_ck;
insert into emp4 (empno, ename,sal,deptno)
    values(9999,'KING',20000,10);
select * from emp4;
--emps4 table의 sal열에 대한 제약조건을 다시 활성화 하는 구문
--enable validate 구문으로 인해 저장된 값들에 대한 제약조건 체크가 이루어짐
-- 앞에서 제약조건을 비활성화하고 입력한 행은 check 제약 조건을 만족하지 못하므로 에러 발생
--저장된 제약조건을 검사하지 않고 활성화
alter table emp4
enable novalidate CONSTRAINT emp4_sal_ck;

--연습문제
--1. 회원 정보를 저장하는 테이블(member)을 생성하세요. 회원 정보는 사용자 아이디(15),
--이름(20), 비밀번호(20), 전화번호(15), 이메일(100)을 포함해야 합니다. 괄호 안의 숫자는 크기입니다. 
--회원 정보를 저장하는 테이블은 사용자 아이디를 PK로 갖습니다.
create table member(
    user_id varchar2(15) not null,
    ename varchar2(10) not null,
    password VARCHAR2(15) not null,
    phone VARCHAR2(15),
    email VARCHAR2(15));
alter table member
add constraint member_user_id_pk PRIMARY KEY(user_id)

--2. 다음 테이블 구문을 수정해서 제약조건을 추가하세요. 
-- DEPT 테이블의 DEPTNO 열은 주키(primary key) 열이어야 합니다. 
-- 제약조건의 이름은 pk_dept로 하세요. 
-- EMP 테이블의 EMPNO 열은 주키(primary key) 열이어야 합니다. 
-- 제약조건의 이름은 pk_emp로 하세요. 
-- EMP 테이블의 DEPTNO 열은 DEPT 테이블의 DEPTNO 열을 참조하는 외래키(foreign key)여야 합니다. 
-- 제약조건의 이름은 fk_deptno로 하세요.
create table dept(
    deptno number(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    constraint pk_dept PRIMARY KEY(deptno)    
);
create table emp(
    empno number(4,0),
    ename vcarchar2(10),
    job varchar2(9),
    mgr number(4,0),
    hiredate date,
    sal number(7,2),
    sal number(7,2),
    comm number(7,2),
    deptno number(2,0),
    constraint pk_emp primary key(empno),
    constraint fk_deptno foreign key(deptno) references dept(deptno)
);