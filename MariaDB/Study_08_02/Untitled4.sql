<Table lavel 부여(제약조건 이름도 부여)>

drop table if exists CT_EMP;
drop table if exists CT_DEPT;


create table CT_DEPT (
    DEPTNO TINYINT,
    DNAME VARCHAR(14) default '개발부',
    LOC CHAR(1),
    primary key(DEPTNO),
    constraint CT_DEPT_CK check ( LOC in ('1','2'))
);

create table CT_EMP (
    NO INT,
    NAME VARCHAR(10) not null,
    ADDR VARCHAR(6),
    JUMIN VARCHAR(13),
    RDATE DATETIME default current_timestamp,
    DEPTNO TINYINT,
    primary key(NO),
    constraint CT_EMP_CK check (ADDR in ('서울','부산')),
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

MariaDB 의 primary key 에는 이름 부여 안됨 (어차피 1개 뿐이니까, 굳이 이름 붙일 필요X)
