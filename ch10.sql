--ch10
-- 1. ȸ�� ������ �����ϴ� ���̺�(member)�� �����ϼ���.
-- ȸ�������� ����ھ��̵�(15), �̸�(20), ��й�ȣ(20), ��ȭ��ȣ(15), �̸���(100)�� �����ؾ��Ѵ�.
create table member(
    userid VARCHAR2(15) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    phone VARCHAR2(15),
    email VARCHAR2(100)
    );
    
select *
from member;

-- 2. ����ھ��̵�, �̸�, ��й�ȣ, ��ȭ��ȣ, �̸����� �����ϴ� ������ �ۼ��ϼ���. 
-- user123, �����, a1234567890, 011-234-5678, user@user.com
insert into
    member(userid,name,password,phone,email)
    values('user123','�����','a1234567890','011-234-5678','user@user.com');

select*
from member;

-- 3. ����ھ��̵� user123�� ������� ��� ������ ��ȸ�ϼ���.
select *
from member
where userid='user123';

-- 4. ����ھ��̵� user123�� ������� �̸�, ��й�ȣ, ��ȭ��ȣ, �̸����� �����ϼ���
-- ȫ�浿,a1234,011-222-3333, user@user.co.kr
update member
set name = 'ȫ�浿', password = 'a1234', phone ='011-222-333',email='user@user.co.kr'
where userid = 'user123';

select *
from member
where name = 'ȫ�浿';

-- 5. ����ھ��̵� user123�̰� ��й�ȣ�� a1234�� ȸ���� ������ �����ϼ���.
delete from member
where userid='user123' and password='a1234';

select *
from member;

-- 6. ȸ�� ������ �����ϴ� ���̺�(member)�� ��� ���� �����ϼ���. TRUNCATE������ �̿�
truncate table member;

-- 7. ȸ�� ������ �����ϴ� ���̺�(member)�� �����ϼ���.
drop table member;