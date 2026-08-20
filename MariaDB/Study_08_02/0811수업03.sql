식별관계(DEPT4/EMP4)생성

	 drop table if exists DEPT4;

	    create table DEPT4(
	     no int primary key,
	     dname varchar(14) not null
	     loc varchar(14) not null
	    );

	    drop table if exists EMP4;

	    create table EMP4(
	     empno int(4) not null,
	     ename varchar(10) not null,
	     job varchar(9) not null,
	     mgr int(4) 
	     hiredate date default (current_date),
	     sal decimal(7,2) not null,
	     comm decimal(7,2),
	     deptno int not null,

	     primary key(empno, deptno), 
	     foreign key(deptno) references dept4(no)
	    );  


--------------------------------------------------------------------------


  alter table emp4 drop primary key;
  
  select * from emp4;
  delete from emp4 where deptno is null;
  select * from emp4;

  alter table emp4 add primary key(empno, deptno); 

  select 
    table_name,
    constraint_name,
    constraint_type
   from information_schema.table_constraints
   where table_name in ('DEPT4', 'EMP4') 
     and constraint_schema = database();

------------------------------------------------------------------------

비식별관계(DEPT5/EMP5)생성

DROP TABLE IF EXISTS DEPT5;

CREATE TABLE DEPT5(
    no    INT PRIMARY KEY,
    dname VARCHAR(14) NOT NULL,
    loc   VARCHAR(14) NOT NULL
);

DROP TABLE IF EXISTS EMP5;

CREATE TABLE EMP5(
    empno    INT(4) NOT NULL PRIMARY KEY,   -- 자식 고유 PK (deptno 미포함!)
    ename    VARCHAR(10) NOT NULL,
    job      VARCHAR(9) NOT NULL,
    mgr      INT(4),
    hiredate DATE DEFAULT (CURRENT_DATE),
    sal      DECIMAL(7,2) NOT NULL,
    comm     DECIMAL(7,2),
    deptno   INT,                            -- NULL 허용 → 부서 미배정 가능(비식별관계 특징)

    FOREIGN KEY(deptno) REFERENCES DEPT5(no)


-----------------------------------------------------------------------

이 자식 데이터가, 부모 없이도(또는 부모가 뭔지와 상관없이) 그 자체로 하나의 유일한 존재인가?

YES → 비식별관계. 자식은 자기만의 정체성(PK)이 있고, 부모는 그냥 "소속 정보"일 뿐.
NO → 식별관계. 자식의 정체성 자체가 "어떤 부모에 속한 몇 번째"로만 정의됨

자식이 "부모가 누구든 상관없이 원래 유일한 존재"면 비식별관계(FK는 그냥 참조용), 
자식이 "부모에 속해야만 비로소 유일해지는 존재"면 식별관계(부모 PK가 자식 PK의 일부)