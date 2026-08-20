drop table if exists EMP_TRI;
create table EMP_TRI(
   empno int primary key, 
   ename varchar(10), 
   sal decimal(7,2)
);

-- 트리거1 정의: '사번만 입력'되면 자동으로 이름과 급여가 업데이트 되는 트리거
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
end$$

delimiter ;

-- 트리거1 확인  
insert into EMP_TRI(empno) values(1000);
select * from EMP_TRI; 


-- 트리거2 정의: EMP_TRI에 insert가 될 때, EMP2 테이블의 값 갱신
delimiter $$
drop trigger if exists TRI_SAL2;

create trigger TRI_SAL2
after 
   insert on EMP_TRI
   for each row
begin
   update EMP2 set ename=new.ename, sal=new.sal 
   where empno=new.empno;
end$$

delimiter ;

-- 트리거2 확인
select empno, ename, sal from emp2;
insert into EMP_TRI(empno) values(7369);  --방아쇠 
select * from EMP_TRI; --by TRI_SAL1
select empno, ename, sal from emp2; --by TRI_SAL2
