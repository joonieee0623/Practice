<SQL>
- DQL (select)
순서가 중요
SF-WGHO (-join종류 관계키(FK-자식table)/Sub Query
dept(deptno [PK(nullx/table에 오직 1개만 가능) or UK(null가능/table에 여러개 정의가능:부모table이 여러개)]
emp(deptno [FK(table에 여러개 정의가능:부모table이 여러개)])

- DML (insert, update, delete)
insert into table1 values(column의 순서대로);
insert into uable1(column1, cloumn2) values(column1값, column2값);

update table1 set column1='값', column2='값' where 특정한 column; -- = : 비교연산자X/대입

delete from table1 where column1='값';

- TCL
transaction : 거래
ex) 계좌이체
 DML1 DML2 DML3 
 ROLLBACK : COMMIT하기 전 작업들을 취소하고 이전 상태로 되돌림. DML2->DML1
	update accout set balance = balance - 10000 where id=1; 
	-- 어 잘못 짰다!
	rollback; --위 update 없었던 걸로

 COMMIT : 지금까지 한 작업들을 확정해서 실제로 DB에 저장
	update account set balance = balance - 10000 where id =1;
	update accoutn set balacne = balance + 10000 where id =2;
	commit; --여기서 진짜로 반영됨/한 번 commit을 하면 되돌릴 수 없음

 SAVEPOINT : 트랜잭션 중간에 저장 지점을 만들어서, 전체가 아니라 일부만 롤백할 수 있음
	savepoint sp1;
	update account set balance = balance - 10000 where id=1;
	rollback to sp1; --sp1 지점가지만 되돌림
 주의할 점 : AUTOCOMMIT
	MariaDB는 기본적으로 AUTOCOMMIT이 켜져 있어서 쿼리 하나 실행할 때마다 자동으로 COMMIT 된다
	rollback을 실습해보려면 :
	set autocommit = 0; --자동 커밋 끄기
	로 먼저 꺼줘야 rollback이 의미가 있다.(DML만 해당, DDL은 자동커밋됨)
	select @@autocommit; --활성화 되어있는지 확인 1: 활성화 / 0: 비활성화

transaction 핵심 개념 
: "여러 작업을 하나의 묶음"으로 처리하는 것. 
 분리되서는 안될(논리적인) '작업단위'
 DML(insert/update/delete) 같은 작업을 실행해도, COMMIT을 해야 진짜로 DB에 반영된다
 DML(insert/update/delete) 실행결과가 DBMS에 '영구저장'되거나, '되돌리기'위한 SQL

 실습1)
 session1>
 select @@autocommit; 
 insert into dept2 values(90, 'a0', 'b0');
 select * from dept2; --90이 보임
 insert into dept2 values(91, 'a1', 'b1');
 select * from dept2; --91이 보임

 session2>
 select * from dept2; --90이 보임
 select @@autocommit; --0
 select * from dept2; --91이 안보임(메모리에만 존재/database에는 x)
 

 실습2)
 session1>
 set @@autocommit=0;
 select @@autocommit; --0
 select * from dept2; --91이 보임

 session2>
 select * from dept2; --91이 안보임

 실습3)
 session1>
 insert into dept2 values(92, 'a2', 'b2');
 savepoint a;
 insert into dept2 values(93, 'a3', 'b3');
 savepoint b;
 select * from dept2; --모두 보임
 rollback to a;
 select * from dept2; --91과 92만 보임
 commit; --savepoint b는 사라짐

 sesiion2>
 select * from dept2; --모두 보이지 않음( commit전 )
 select * from dept2; --91과 92가 보임 ( commit후)

 delete from dept2 where deptno>=92;

 실습4)

 session2>
 insert into dept2 values(94, 'a4', 'b4');
 session1>
 select * from dept2; --94 안보임

 session1>
 create table A(no int); --중간에 DDL 수행하면 자동commit 됨
 session2>
 select * from dept2; --94 보임

 실습5)

 session1> 
 insert into dept2 values(95, 'a5', 'b5');
 quit; --정상종료: rollback됨(비정상종료는 당연히 rollback)
 어떤 트랜잭션이 실행 중인데, 나가버리면
 session2>
 select * from dept2; --95안보임(commit 안됨)

