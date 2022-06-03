--ch11
-- 1. ȸ�� ������ �����ϴ� ���̺�(member)�� �����ϼ���. 
-- ȸ�� ������ ����� ���̵�(15), �̸�(20), ��й�ȣ(20), ��ȭ��ȣ(15), �̸���(100)�� �����ؾ� �մϴ�. 
-- ��ȣ ���� ���ڴ� ũ���Դϴ�. 
--ȸ�� ������ �����ϴ� ���̺��� ����� ���̵� PK�� �����ϴ�.
create table member(
    userid VARCHAR2(15) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR2(100)
    );

alter table member
add constraint member_userid_pk PRIMARY KEY (userid);

--2. ���� ���̺� ������ �����ؼ� ���������� �߰��ϼ���. 
-- DEPT ���̺��� DEPTNO ���� ��Ű(primary key) ���̾�� �մϴ�. 
-- ���������� �̸��� pk_dept�� �ϼ���. 
-- EMP ���̺��� EMPNO ���� ��Ű(primary key) ���̾�� �մϴ�. 
-- ���������� �̸��� pk_emp�� �ϼ���. 
-- EMP ���̺��� DEPTNO ���� 
-- DEPT ���̺��� DEPTNO ���� �����ϴ� �ܷ�Ű(foreign key)���� �մϴ�. 
-- ���������� �̸��� fk_deptno�� �ϼ���

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