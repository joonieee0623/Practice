drop table if exists CT_EMP;
drop table if exists CT_DEPT;

create table CT_DEPT (
    DEPTNO TINYINT,
    DNAME VARCHAR(14) default '개발부',
    LOC CHAR(1),
    primary key(DEPTNO),
    check ( LOC in ('1','2'))
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


show tables;
show create table CT_DEPT;
show create table CT_EMP;


table level

create table CT_DEPT (
    DEPTNO TINYINT,
    DNAME VARCHAR(14) default '개발부',
    LOC CHAR(1),
    primary key(DEPTNO),
    constraint CT_DEPT_CK check ( LOC in ('1','2'))
);

column level

create table CT_DEPT (
    DEPTNO TINYINT constraint ct_dept_pk primary key,
    DNAME VARCHAR(14) default '개발부',
    LOC CHAR(1),
    constraint CT_DEPT_CK check ( LOC in ('1','2'))
);