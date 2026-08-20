delimiter $$
drop procedure if exists INCRE;

create procedure INCRE(in N int, in R decimal(7,2))
begin 
  declare newpay decimal(7,2);

  select sal into newpay from emp2 where empno=N;
  set newpay = newpay + (newpay*R);

  update emp2 set sal=newpay where empno=N;
  commit;

end$$

delimiter ;

-- call INCRE(7369, 0.1);
-- select empno, sal from emp2;