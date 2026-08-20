<PL-SQL>

1. Procedure
 일련의 '작업처리순서'를 정의해 놓은 것으로 미리 DBMS에 컴파일 되어져서,
 '프로그램' or '사용자'로부터 호출되면 실행되는 일종의 '알고리즘'
 
 함수는 무조건  return 값이 있지만, 이건 return 값이 필요 없음

 1)

 delimiter $$

 drop procedure if exists INCRE 

 create procedure INCRE(in N int, in R decimal(10, 2))
 begin
   declare newpay decimal(10,2);

   select sal into newpay from emp2 where empno=N;
   set newpay = newpay +(newpay*R);
   update emp2 set sal=newpay where empno=N;
   commit;

 end $$
   
 delimiter;

 --call INCRE(7369, 0.1);
 --select empno, sal from emp2;

 2)
 delimiter $$

 drop procedure if exists INCRE2

 create procedure INCRE2(in N int, in R decimal(7, 2))
 begin
   declare newpay decimal(7,2);

   select sal into newpay from emp2 where empno=N;
   set newpay = newpay +(newpay*R/100);
   update emp2 set sal=newpay where empno=N;
   commit;

 end $$
   
 delimiter;

 --call INCRE2(7369, 10);
 --select empno, sal from emp2;

 (1) 모양
  delimiter
  drop procedure if exists 프로시저이름;

  create procedure 프로시저이름(in 지역변수 타입, in R decimal(7, 2))
  begin
   declare 전역변수 타입(7,2);
   
   SQL 로직
  
  end $$
   
  delimiter;

 (2) 확인
  desc information_schema.routines;

  select ROUTINE_NAME
  from information_shcema.rotines
  where ROUTINE_TYPE = 'Procedure'
   and ROUTINE_SCHEMA = 'python_schema';

2. trigger
 일련의 '작업처리순서'를 정의해 놓은 것으로 미리 DBMS에 컴파일 되어져서,
 어떤 조건이 만족되엊이는 상황(='DML수행')이 발생되면,
 '자동'호출 되어져서 작동되는 알고리즘

 --트리거1: '사번만 입력'되면 자동으로 이름과 급여 업데이트 되는 트리거
 --정의
 drop table if exists EMP_TRI;

 create table EMP_TRI(
	empno int primary key,
	ename varchar(10),
	sal decimal(7,2)
 );

 delimiter $$

 drop trigger if exists TRI_SAL1;

 create trigger TRI_SAL1
 before
  insert on EMP_TRI
  for each row
 begin
  if new.ename is null then 
    set new.ename='이순신';
  end if;

  if new.sal is null then
   set new.sal=3000;
  end if;

 end $$

 delimiter ;

 --확인
 insert into EMP_TRI(empno) values(1000);
 select * from EMP_TRI;

--트리거2: 
 --정의
 drop table if exists EMP_TRI;

 create table EMP_TRI(
	empno int primary key,
	ename varchar(10),
	sal decimal(7,2)
 );

 delimiter $$

 drop trigger if exists TRI_SAL2;

 create trigger TRI_SAL2
 after
  insert on EMP_TRI
  for each row
 begin
  update EMP2 set ename=new.ename, sal=new.sal
  where empno=new.empno;

 end $$

 delimiter ;

 --확인
 select empno, ename, sal from emp2;
 insert into EMP_TRI(empno) values(7369); --방아쇠
 select * from EMP_TRI; --by TRI_SAL1
 select empno, ename, sal from emp2; --by TRI_SAL2

프로시저, 트리거는 전혀 사용하지 안하도 프로젝트 가능
-> backend에서도 가능

<프로시저, 트리거 사용시 장점>
 - 장점 : 로직 숨김(보안강화)
	 속도 빠름
 - 단점 : 수정 어려움

(1) 모양
 delimiter $$

 drop trigger if exists 트리거이름;

 create trigger 트리거이름
  before | after
   --XX경우,(DML수행할 때)
  
  begin
  --YY해라
  end $$

 delimiter ;

(2) 확인

 desc information_schema.triggers;

 select TRIGGER_NAME
  from information_shcema.triggers  --시스템테이블/데이터 딕셔너리(자체적인 테이블)
  where TRIGGER_SCHEMA = database();
  