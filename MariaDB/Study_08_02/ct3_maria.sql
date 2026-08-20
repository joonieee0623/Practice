-- [3] Table Level 부여(제약조건이름O)  

-- 1. 기존 테이블 삭제
drop table if exists CT_EMP;
drop table if exists CT_DEPT;

-- 2. CT_DEPT 테이블 생성 (PK, DEFAULT, CHECK 부여예정)
create table CT_DEPT (
    DEPTNO TINYINT,
    DNAME VARCHAR(14) default '개발부',
    LOC CHAR(1),
    primary key(DEPTNO), 
    constraint CT_DEPT_CK check ( LOC in ('1','2'))
);

-- 3. CT_EMP 테이블 생성 (PK, NOT NULL, CHECK, UNIQUE, DEFAULT, FK 부여예정)
create table CT_EMP (
    NO INT ,
    NAME VARCHAR(10) not null,
    ADDR VARCHAR(6) ,
    JUMIN VARCHAR(13) ,
    RDATE DATETIME default current_timestamp,
    DEPTNO TINYINT, 
    primary key(NO), 
    constraint CT_EMP_CK check ( ADDR in ('서울','부산')), 
    constraint CT_EMP_UQ unique(JUMIN), 
    constraint CT_EMP_FK foreign key(DEPTNO) references CT_DEPT(DEPTNO)
);

select
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
from information_schema.TABLE_CONSTRAINTS
where TABLE_NAME IN ('CT_DEPT', 'CT_EMP')
  and CONSTRAINT_SCHEMA = DATABASE();