-- 1. 테이블 삭제
drop table if exists EMP2;
drop table if exists DEPT2;

-- Oracle의 purge recyclebin은 MariaDB에는 없음

-- 2. 테이블 생성
create table DEPT2 (
    DEPTNO TINYINT primary key,
    DNAME VARCHAR(14),
    LOC VARCHAR(13)
);

create table EMP2 (
    EMPNO INT primary key,
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    MGR INT,
    HIREDATE DATE,
    SAL DECIMAL(7,2),
    COMM DECIMAL(7,2),
    DEPTNO TINYINT,
    constraint EMP2_FK foreign key (DEPTNO) references DEPT2(DEPTNO)
); --on delete cascade

-- 3. 기존 테이블에서 데이터 복사
insert into DEPT2 select * from DEPT;
insert into EMP2 select * from EMP;

commit;

-- 4. 테이블 구조 확인
-- MariaDB에서는 DESC 또는 SHOW COLUMNS 사용
desc DEPT2;
desc EMP2;

-- 5. 데이터 확인
select * from DEPT2;
select * from EMP2;

-- 6. 제약 조건 확인
-- MariaDB에서는 `information_schema`를 사용해야 함
select 
    TABLE_NAME, 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE 
from information_schema.TABLE_CONSTRAINTS 
where TABLE_NAME IN ('DEPT2', 'EMP2')
  and CONSTRAINT_SCHEMA = DATABASE();

-- 8. 테이블 리스트
show tables;