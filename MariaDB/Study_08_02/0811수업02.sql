 

2번 방법
[1] 테이블 복사
 1. 테이블 삭제
  drop table if exists DEPT4;
  drop table if exists EMP4;

 2. 테이블 생성(기존 테이블에서 복사)
  create table DEPT4 as select * form DEPT;
  create table EMP4 as select * form EMP;

 3. 제약조건 추가
  alter table DEPT4 add constraint DEPT4_PK primary key(deptno);
  alter table EMP4 add constraint EMP4_PK primary key(emptno);
  alter table EMP4 add constraint EMP4_FK foreign key(deptno) references DEPT4(deptno)
   on delete cascade;

 4. 테이블 구조 확인
  desc DEPT4;
  desc EMP4;

 5. 데이터 확인
  select * from DEPT4;
  select * from EMP4;

 6. 제약조건 확인
  select 
    table_name,
    constraint_name,
    constraint_type
   from information_schema.table_constraints
   where table_name in ('DEPT4', 'EMP4') 
     and constraint_schema = database();

  7. 테이블 리스트
   show tables;

   
  1) PK 삭제
  alter table emp4 drop primary key;
  desc emp4; --확인
  
  2) deptno null 컬럼 데이터 제거
  select * from emp4;
  delete from emp4 where deptno is null;
  select * from emp4;

  3) PK 생성
  alter table emp4 add primary key(empno, deptno); --PK는 1개, 2개의 컬럼이 참여한 것 
  desc emp4;

  4) PK 생성 확인

  select 
    table_name,
    constraint_name,
    constraint_type
   from information_schema.table_constraints
   where table_name in ('DEPT4', 'EMP4') 
     and constraint_schema = database();

  5) 차이확인
  insert into emp4(empno, ename, deptno) values(7369, '강감찬', 10);
  --가능)실제 입력됨 -> 7369 사원이 2명이 됨 
  --PK가 중복?? 
  insert into emp4(empno, ename, deptno) values(7369, '이순신', 20);
  --불가능) empno, deptno 합쳐져서 PK(고유함) 
  insert into emp4(empno, ename, deptno) values(9999, '홍길동', 20);
  --가능) 둘 중에 하나만 다르면 가능
  select * from emp4;


슬랙

-- [1] 테이블 복사

-- 1. 테이블 삭제
drop table if exists EMP4;
drop table if exists DEPT4;

-- 2. 테이블 생성 (기존 테이블에서 복사)
create table DEPT4 as select * from DEPT;
create table EMP4 as select * from EMP;

-- 3. 제약 조건 추가
alter table DEPT4
  add constraint DEPT4_PK primary key (DEPTNO);

alter table EMP4
  add constraint EMP4_PK primary key (EMPNO);

alter table EMP4
  add constraint EMP4_FK foreign key (DEPTNO)
  references DEPT4(DEPTNO)
  on delete cascade;

-- 4. 테이블 구조 확인
desc DEPT4;
desc EMP4;

-- 5. 데이터 확인
select * from DEPT4;
select * from EMP4;

-- 6. 테이블 리스트
show tables;


-- [2] 제약조건 확인

-- 1. 제약조건 확인
select
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
from information_schema.TABLE_CONSTRAINTS
where TABLE_NAME IN ('DEPT4', 'EMP4')
  and CONSTRAINT_SCHEMA = DATABASE();

-- 2. PK삭제
alter table emp4 drop primary key;
desc emp4; --확인

-- 3. DEPTNO null컬럼 데이터 제거
select * from emp4;
delete from emp4 where deptno is null;
select * from emp4;

-- 4. PK생성
alter table EMP4 add primary key(EMPNO, DEPTNO);
desc EMP4;

-- 5. PK생성확인
desc EMP4;

select
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
from information_schema.TABLE_CONSTRAINTS
where TABLE_NAME IN ('DEPT4', 'EMP4')
  and CONSTRAINT_SCHEMA = DATABASE();

-- 6. 차이확인
insert into EMP4(EMPNO, ENAME, DEPTNO) values(7369, '강감찬', 10);--가능
insert into EMP4(EMPNO, ENAME, DEPTNO) values(7369, '이순신', 20);--불가
insert into EMP4(EMPNO, ENAME, DEPTNO) values(9999, '홍길동', 20);--가능
select * from emp4;