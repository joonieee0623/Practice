< 문제 (FUNCTION) >

(1) EMP Table에서 이름, 급여, 커미션 금액, 총액(sal+comm)을 구하여 총액이 
    많은 순서로 출력하라. 단, 커미션이 NULL인 사람은 제외한다. 
	
	select ename, sal, comm, sal+comm 총액 from emp 
	where comm is not NULL order by 총액 desc;
	
(2) 10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지불하기로 하였다.
    이름, 급여, 보너스 금액, 부서 번호를 출력하라.
	
	select ename, sal, sal*0.13 as bonus, deptno from emp where deptno=10;

(3) 30번 부서의 연봉을 계산하여 이름, 부서번호, 급여, 연봉을 출력하라.
    단, 연말에 급여의 150%를 보너스로 지급한다. 
	
	select ename, deptno, sal, sal*12 + sal*1.5 as 연봉 from emp where deptno=30;
   
(4) 부서 번호가 20인 부서의 시간당 임금을 계산하여 출력하라.
    단, 1달의 근무일수는 12일이고, 1일 근무시간은 5시간이다.
    출력양식은 이름, 급여, 시간당 임금(소수이하 1번째 자리에서 반올림)
    을 출력하라. 
	
	select ename, sal, round(sal/(12*5)) as 시급 from emp where deptno=20;

(5) 급여가 $1,500 부터 $3,000 사이의 사람은 급여의 15%를 회비로 지불하기로 하였다.
    이를 이름, 급여, 회비(-2자리에서 반올림)를 출력하라.
	
	select ename, sal, round(sal*1.5, -2) as 회비 from emp 
	where sal between 1500 and 3000;
	   
(6) 급여가 $2,000 이상인 모든 사람은 급여의 15%를 경조비로 내기로 하였다. 
    이름, 급여, 경조비(소수점 이하 절삭)를 출력하라.
	
	select ename, sal, truncate(sal*1.5, 0) as 경조비 from emp where sal>=2000;

(7) 입사일부터 지금까지의 날짜수를 출력하라.
    부서 번호, 이름, 입사일, 현재일, 근무일수(소수점 이하 절삭), 
	근무년수(반올림),근무월수(30일 기준,반올림), 근무주수(반올림)를 출력하라.
	
	select deptno, ename, hiredate, curdate() as 현재일, datediff(curdate(), hiredate) as 근무일수,
	round(datediff(curdate(), hiredate)/365) as 근무년수, round(datediff(curdate(), hiredate)/30) as 근무월수, 
	round(datediff(curdate(), hiredate)/7) as 근무주수 from emp;
	
	
(8) 모든 사원의 실수령액을 계산하여 출력하라.
    단, 급여가 많은 순으로 이름, 급여, 실수령액을 출력하라
    (실수령액은 급여에 대해 10%의 세금을 뺀 금액)
	
	select ename, sal, sal*0.9 as 실수령액 from emp order by sal desc;

(9) 입사일로부터 90일이 지난 후의 사원 이름, 입사일, 90일 후의 날, 급여를 출력하라.
	
	select ename, hiredate, date_add(hiredate, interval 90 day) as 90일후, sal from emp;
	
(10) 입사일로부터 6개월이 지난 후의 입사일, 6개월 후의 날짜, 급여를 출력하라.
	
	select hiredate, date_add(hiredate, interval 6 month) as 6개월후, sal from emp;

(11) 입사한 달의 근무일수를 계산하여 부서번호, 이름, 입사일, 근무일수를 출력하라.
	
	select deptno, ename, hiredate, last_day(hiredate) - hiredate +1 as 근무일수 from emp;

(12) 모든 사원의 60일이 지난 후의 'MONDAY'는 몇 년, 몇 월, 몇 일 인가를 구하여
     이름, 입사일, 'MONDAY'를 출력하라.(입사일로부터 60일이 지난 후의 monday)

	select ename, hiredate, 
		date_add(date_add(hiredate, interval 60 day),
			interval ( 7 - weekday(date_add(hiredate, interval 60 day))) day) as "MONDAY"
	from emp;
	
	--------------------------------------------------------------------------------------------------
	SELECT ename, hiredate,
        DATE_ADD(hiredate, INTERVAL 60 + (7 - WEEKDAY(hiredate + 60)) DAY) AS MONDAY
	FROM emp;
	---WEEKDAY() : 월요일=0, 화요일=1, ... 일요일=6
	---7 - WEEKDAY(...) : 그 날짜로부터 (다음 주) 월요일까지 남은 일수
	---전체를 DATE_ADD(hiredate, INTERVAL ... DAY) 하나로 묶어서 date_add를 두 번 쓰지 않도록 함
	--------------------------------------------------------------------------------------------------
(13) 입사일로부터 오늘까지의 일수를 구하여 이름, 입사일, 근무일수(반올림)를 
     출력하라.
	 
	 select ename, hiredate, round(datediff(curdate(), hiredate))as 근무일수 from emp;
	
(14) 입사일을 '1996년 5월 14일'의 형태로 이름, 입사일을 출력하라.
	 
	 select ename, date_format(hiredate,'%y년 %m월 %d일') as hiredate from emp;
	 select ename, date_format(hiredate,'19%y년 %m월 %d일') as hiredate from emp;

(15) 이름의 글자수가 6자 이상인 사람의 이름을 앞에서 3자만 구하여 
     소문자로 이름만을 출력하라.

	select lower(substr(ename, 1, 3)) as name from emp where length(ename)>=6; 

(16) 10번 부서 월급의 평균, 최고, 최저, 인원수를 구하여 출력하라.
	
	select avg(sal), max(sal), min(sal), count(*) from emp where deptno=10;

(17) 각 부서별 급여의 평균, 최고, 최저, 인원수를 구하여 출력하라.
     (부서번호도 출력)
	 
	 select avg(sal), max(sal), min(sal), deptno from emp group by deptno;

(18) 각 부서별 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무명, 인원수를 출력하라.
	
	select deptno, job, count(empno) from emp group by deptno, job;

(19) 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하라.
    
	select job, count(empno) from emp group by job having count(ename)>=4;

(20) 각 부서별 평균 월급, 전체 월급, 최고 월급, 최저 월급을 구하여 평균 월급이 
     많은 순으로 출력하라. (부서번호도 출력)

	select avg(sal), sum(sal), max(sal), min(sal), deptno from emp group by deptno order by sal desc;

Tip) 문제의 해석이 모호할 때는 XXX 
   경우1) 만약 A라 B를 의미한다면.. 
      SQL1> ... 

   경우2) 만약 A라 C를 의미한다면..
      SQL2> ...
   