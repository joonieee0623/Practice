root에서 해야 함

<DCL> --grant, revoke
(1)계정 생성

create user 'test'@'localhost' identified by 'python'; --'python' : password
--(옵션) create user 'test'@'%' identified by 'python'; 

(2) DB생성 및 권한 부여

show databases;
use mysql
desc user;
select Host, User, Password from user;[오전 10:09]create database test_schema;
show databases;

C:\Program Files\MariaDB 12.3\data\test_schema --파일 생성됨(파일위치)


test password:1234
grant all privileges on test_schema.* to 'test'@'localhost';
grant : DCL
flush privileges;

show grants for 'test'@'localhost'; --권한 확인

(3) 권한 제거

revoke all privileges on test_schema.* from 'test'@'localhost';
--(option) revoke all privileges on test_shcema.* from 'test'@'&';
show grants for 'test'@'localhost'; --권한 확인

(4) 비번 변경
alter user 'test'@'localhost' identified by 'py' --passwrod바뀜

새로운 session(cmd) 열어서 확인
cd\
mysql\ -u test -p -h localhost;
enter password;
select user();

(5) 계정 삭제

drop user 'test'@'localhost';
--(option) drop user 'test'@'%'; 

select user, password, host from user; --확인

(6) DB 삭제
drop database test_schema;
show databases; --확인
C:\Program Files\MariaDB 12.3\data -- test_schema 폴더 사라짐(삭제 확인)


