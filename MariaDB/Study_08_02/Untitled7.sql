<PL-SQL>

1. Procedure
 일련의 '작업처리순서'를 정의해 놓은 것으로 미리 DBMS에 컴파일 되어져서,
 '프로그램' or '사용자'로부터 호출되면 실행되는 일종의 '알고리즘'
 
 함수는 무조건  return 값이 있지만, 이건 return 값이 필요 없음
 1)

 delimiter $$

 drop procedure if exists INCRE $$

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

 drop procedure if exists INCRE2 $$

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

  create procedure 프로지저이름(in 지역변수 타입, in R decimal(7, 2))
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
