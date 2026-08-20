
-- 1. 기존 테이블 삭제
drop table if exists CT_EMP;
drop table if exists CT_DEPT;

-- 2. CT_DEPT 테이블 생성 (PK, DEFAULT, CHECK 부여예정)
create table CT_DEPT (
    DEPTNO TINYINT primary key,
    DNAME VARCHAR(14) default '개발부',
    LOC CHAR(1) check ( LOC in ('1','2'))
);

-- 3. CT_EMP 테이블 생성 (PK, NOT NULL, CHECK, UNIQUE, DEFAULT, FK 부여예정)
create table CT_EMP (
    NO INT primary key,
    NAME VARCHAR(10) not null,
    ADDR VARCHAR(6) check ( ADDR in ('서울','부산')),
    JUMIN VARCHAR(13) unique,
    RDATE DATETIME default current_timestamp,
    DEPTNO TINYINT references CT_DEPT(DEPTNO)
);

select
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
from information_schema.TABLE_CONSTRAINTS
where TABLE_NAME IN ('CT_DEPT', 'CT_EMP')
  and CONSTRAINT_SCHEMA = DATABASE();

2.
alter table CT_DEPT add primary key(DEPTNO);
alter table CT_DEPT add constraint CT_DETPT_CK check (LOC in ('1', '2'));
alter table CT_DEPT add constraint CT_DETPT_CK check (ADDR in ('서울', '부산'));
alter table CT_DEPT add constraint CT_DETPT_UQ unique(JUMIN);
alter table CT_DEPT add constraint CT_DETPT_FK foreign key 

alter table CT_DEPT modify DNAME varchar(14) default '개발부';
  
