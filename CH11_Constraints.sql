--ch11
-- 1. 회원 정보를 저장하는 테이블(member)을 생성하세요. 
-- 회원 정보는 사용자 아이디(15), 이름(20), 비밀번호(20), 전화번호(15), 이메일(100)을 포함해야 합니다. 
-- 괄호 안의 숫자는 크기입니다. 
--회원 정보를 저장하는 테이블은 사용자 아이디를 PK로 갖습니다.
create table member(
    userid VARCHAR2(15) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR2(100)
    );

alter table member
add constraint member_userid_pk PRIMARY KEY (userid);

--2. 다음 테이블 구문을 수정해서 제약조건을 추가하세요. 
-- DEPT 테이블의 DEPTNO 열은 주키(primary key) 열이어야 합니다. 
-- 제약조건의 이름은 pk_dept로 하세요. 
-- EMP 테이블의 EMPNO 열은 주키(primary key) 열이어야 합니다. 
-- 제약조건의 이름은 pk_emp로 하세요. 
-- EMP 테이블의 DEPTNO 열은 
-- DEPT 테이블의 DEPTNO 열을 참조하는 외래키(foreign key)여야 합니다. 
-- 제약조건의 이름은 fk_deptno로 하세요

CREATE TABLE dept(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    CONSTRAINT	pk_dept	PRIMARY	KEY(deptno)
);

create table emp(
    empno NUMBER(4,0),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4,0),
    hiredate date,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2,0),
    CONSTRAINT pk_emp PRIMARY KEY(empno),
    CONSTRAINT fk_deptno FOREIGN KEY(depto) REFERENCES dept(deptno)
    );
