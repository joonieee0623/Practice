-- 1. 테이블 삭제
drop table if exists EMP3;
drop table if exists DEPT3;

-- 2. Oracle의 `purge recyclebin`은 MariaDB에 없음

-- 3. 테이블 생성 (기존 테이블에서 복사)
-- MariaDB는 `CREATE TABLE ... AS SELECT ...`을 지원하지만 제약조건은 복사되지 않음

create table DEPT3 as select * from DEPT;
create table EMP3 as select * from EMP;

-- 4. 제약 조건 추가
alter table DEPT3 
  add constraint DEPT3_PK primary key (DEPTNO);

alter table EMP3 
  add constraint EMP3_PK primary key (EMPNO);

alter table EMP3 
  add constraint EMP3_FK foreign key (DEPTNO) 
  references DEPT3(DEPTNO) 
  on delete cascade;

-- 5. 테이블 구조 확인
desc DEPT3;
desc EMP3;

-- 6. 데이터 확인
select * from DEPT3;
select * from EMP3;

-- 7. 제약조건 확인
select 
    TABLE_NAME, 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE 
from information_schema.TABLE_CONSTRAINTS
where TABLE_NAME IN ('DEPT3', 'EMP3')
  and CONSTRAINT_SCHEMA = DATABASE();

-- 8. 테이블 리스트
show tables;