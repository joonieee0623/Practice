delimiter $$
drop procedure if exists INCRE2;

create procedure INCRE2(in N int, in R decimal(7,2))
begin 
  declare newpay decimal(7,2);

  select sal into newpay from emp2 where empno=N;
  set newpay = newpay + (newpay*R/100);

  update emp2 set sal=newpay where empno=N;
  commit;

end$$

delimiter ;

-- call INCRE2(7369, 10);
-- select empno, sal from emp2;