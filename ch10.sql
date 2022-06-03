--ch10
-- 1. 회원 정보를 저장하는 테이블(member)을 생성하세요.
-- 회원정보는 사용자아이디(15), 이름(20), 비밀번호(20), 전화번호(15), 이메일(100)을 포함해야한다.
create table member(
    userid VARCHAR2(15) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    phone VARCHAR2(15),
    email VARCHAR2(100)
    );
    
select *
from member;

-- 2. 사용자아이디, 이름, 비밀번호, 전화번호, 이메일을 저장하는 쿼리를 작성하세요. 
-- user123, 사용자, a1234567890, 011-234-5678, user@user.com
insert into
    member(userid,name,password,phone,email)
    values('user123','사용자','a1234567890','011-234-5678','user@user.com');

select*
from member;

-- 3. 사용자아이디가 user123인 사용자의 모든 정보를 조회하세요.
select *
from member
where userid='user123';

-- 4. 사용자아이디가 user123인 사용자의 이름, 비밀번호, 전화번호, 이메일을 수정하세요
-- 홍길동,a1234,011-222-3333, user@user.co.kr
update member
set name = '홍길동', password = 'a1234', phone ='011-222-333',email='user@user.co.kr'
where userid = 'user123';

select *
from member
where name = '홍길동';

-- 5. 사용자아이디가 user123이고 비밀번호가 a1234인 회원의 정보를 삭제하세요.
delete from member
where userid='user123' and password='a1234';

select *
from member;

-- 6. 회원 정보를 저장하는 테이블(member)의 모든 행을 삭제하세요. TRUNCATE구문을 이용
truncate table member;

-- 7. 회원 정보를 저장하는 테이블(member)를 삭제하세요.
drop table member;