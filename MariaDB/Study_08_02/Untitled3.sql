-- 1. 기존 테이블 삭제
drop table if exists CT_EMP;
drop table if exists CT_DEPT;

-- 2. CT_DEPT 테이블 생성 (PK, DEFAULT, CHECK 부여예정) --default는 제약조건x
create table CT_DEPT (
    DEPTNO TINYINT primary key
    DNAME VARCHAR(14), default '개발부',
    --insert into ct_dept(deptno, loc) values(10,'1'); 여기서 dname 들어가야하는데 안들어갈 때, default
    LOC CHAR(1) check (LOC in ('1', '2'))
);

-- 3. CT_EMP 테이블 생성 (PK, NOT NULL, CHECK, UNIQUE, DEFAULT, FK 부여예정)
create table CT_EMP (
    NO INT,
    NAME VARCHAR(10), not null,
    ADDR VARCHAR(6) check (ADDR in ('서울', '부산')), --한글 bite 
    JUMIN VARCHAR(13) unique,
    RDATE DATETIME default current_timestamp,
    DEPTNO TINYINT references CT_DEPT(DEPTNO)
);

--다른 방법 : source +드래그

--CT 부여 안됨

desc ct_dept; --CT확인
desc ct_emp;

show databases;
--여기에 information_schema 가 있는데 마리아디비 설치할 때 저장되어 있는데, 기본적으로 여기에 제약조건이 저장됨
desc information_schema.table_constraints;
--DB를 관리, 운용하기 위해 존재

제약조건 확인 명령어
select table_name, constraint_name, constraint_type 
	from information_schema.table_constraints 
	where table_name in ('CT_DEPT' 'CT_EMP') 
	and constraint_schema=database();
-- empty set 출력됨 (현재)
--위왁 같은 내용(선생님)
--제약조건 확인 SQL
select TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
	from information_schema.table_constraints
	where TABLE_NAME in ('CT_DEPT', 'CT_EMP')
	and CONSTRAINT_SCHEMA=database();