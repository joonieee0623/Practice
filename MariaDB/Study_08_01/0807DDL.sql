DDL

DBMS 내에 객체(Object)를 '생성', '변경', '삭제'등을 하기 위한 SQL

Object :
table(dadtabase안에)
index
view
user
database
procedure(function과 비슷하지만 return값이 없음)
trigger 

종류 :
create
alter
drop
rename
comment
truncate

(1) create
 --생성
 create table ddltest(
	no int,
	id varchar(12),
	pwd varchar(12)
	);
 show tables;
 desc ddltest;
 --입력
 insert into ddltest values(1000, 'a1', 'b1');
 insert into ddltest values(2000, 'a2', 'b2');
 insert into ddltest values(3000, 'a3', 'b3');
 select * from ddltest;
 select @@atuocommit; --1

 --복사 방법1
 create table ddltest2(
	no int, 
	id varchar(12),
	pwd varchar(12)
 );
 insert into ddltest2 select * from ddltest; --as생략
 select * from ddltest2;

 --복사 방법2
 create table ddltest3 select * from ddltest;
 select * from ddltest3;
 
 --만약 원본(처음)create에 PK가 있다면, 이건 복사 안됨

(2) alter
 - option
  1) add
   alter table ddltest2 add(addr varchar(30));
   insert into ddltest2 values(4000, 'a4', 'b4', 'Seoul');
   select * from ddltest2;
   --바람직x, database낭비(설계잘못) 그럴때 어쩔수 없이 씀

  2) modify
   insert into ddltest2(no, id) values(5000,'a1234656789012345'); --error(12개 넘어서)
   alter table ddltest2 modify id varchar(20), modify pwd varchar(20);
   desc ddltest2; 
   insert into ddltest2(no, id) values(5000,'a1234656789012345');
   select * from ddltest2;

  3) rename column
   alter table ddltest2 rename column pwd to pass;
   desc ddltest2; 

  4) add constraint
   alter table ddltest2 add constraint ddltest2_pk primary key(no);
   desc ddltest2;

  5) drop constraint
   alter table ddltest2 drop constraint primary key;
   desc ddltest2;

(3) drop
   drop table ddltest2;
   show tables;

(4) rename
   rename tables ddltest3 to ddltest33;
   show tables;

(5) comment 
   1) table
     alter table ddltest comment='수쌤이 만든 ddltest용 table'; --부여
     show table status like 'ddltest'\G; --확인

   2) column
     alter table ddltest modify column no int comment '식별번호'; --부여
     show full columns from ddltest; --확인

 (6) truncate
     select * from ddltest33; --3개
     truncate ddltest33; 
     select * from ddltest33; --empty 데이터가 잘려서 사라짐
     #Tip) delete와의 차이점
      1. where 절 사용 불가
      2. rollback이 안됨(MariaDB 10.0.3이상에서 트랜잭션 안에서 사용시 롤백가능)
      3. 속도가 빠름('장점') -테이블 전체를 통째로 초기화/ '모든 행 삭제'가 아니라 '테이블을 비웠다고 마킹'
	 반면, delete는 각 행을 하나씩 삭제하고, 그 과정을 모두 로그로 남겨야 함(롤백을 위해서)


   