--���̺� ������ ����
--1. ȸ�� ������ �����ϴ� ���̺�(member)�� �����Ͻÿ�.
-- ȸ�������� ����ھ��̵�(15), �̸�(20), ��й�ȣ(20), ��ȭ��ȣ(15), �̸���(100)�� ����
create table member(
    userid VARCHAR2(15) not null,
    name VARCHAR2(20) not null,
    password VARCHAR2(20) not null,
    phone varchar2(15),
    email varchar2(100)
);

--2. ����ھ��̵�, �̸�, ��й�ȣ, ��ȭ��ȣ, �̸����� �����ϴ� ������ �����ϱ�.
--user123, �����, a1234567890, 011-234-5678, user@user.com
insert into 
    member(userid, name, password, phone, email)
    values ('user123', '�����', 'a1234567890', '011-234-5678','user@user.com');

--3. ����ھ��̵� user123�� ������� ��� ������ ��ȸ�Ͻÿ�.
select * from member
where userid='user123';

--4. ����� ���̵� user123�� ������� �̸�, ��й�ȣ, ��ȭ��ȣ, �̸����� �����ϼ���.
--ȫ�浿,a1234,011-222-3333,user@user.co.kr
update member
set name='ȫ�浿',password = 'a1234', phone='011-222-3333', email = 'user@user.co.kr'
where userid = 'user123';

--5. �����̵� =user123, pw=a1234�� ȸ�� ���� ����
delete from member
where userid = 'user123' and password = 'a1234';

--6. ȸ�� ������ �����ϴ� ���̺�(member)�� ��� ���� �����ϼ���.
TRUNCATE TABLE member;

--7. ȸ�� ������ �����ϴ� ���̺�(member)�� �����ϼ���.
drop table member;