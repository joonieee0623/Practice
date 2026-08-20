< DCL >

(1) 계정 생성
C:\>mysql -u root -p
select user();
create user 'test'@'localhost' identified by 'python';
--(옵션) create user 'test'@'%' identified by 'python';[10:06 AM]show databases;
use mysql
desc user;
select Host, User, Password from user;

(2) DB생성 및 권한 부여
create database test_schema;
show databases;
--C:\Program Files\MariaDB 12.3\data\test_schema 생성됨

grant all privileges on test_schema.*  to 'test'@'localhost';
flush privileges;
show grants for 'test'@'localhost';

(3) 권한 제거
revoke all privileges on test_schema.* from 'test'@'localhost';
show grants for 'test'@'localhost'; --권한확인

(4) 비밀번호 변경
alter user 'test'@'localhost' identified by 'py';
C:\>mysql -u test -p -h localhost --또 다른 세션창에서 ..
Enter password: **
select user();

(5) 계정 삭제
drop user 'test'@'localhost';
--(옵션) drop user 'test'@'%';
select user, password, host from user; --확인

(6) DB 삭제
drop database test_schema;
show databases;
--C:\Program Files\MariaDB 12.3\data\test_schema 삭제확인