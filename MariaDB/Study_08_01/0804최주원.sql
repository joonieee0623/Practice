< 문제 (SELECT) >


(1) 부서번호가 10번인 부서의 사람 중 사원번호, 이름, 월급을 출력하라 

	MariaDB [python_schema]> select empno, ename, sal from emp where deptno=10;

(2) 사원번호가 7369인 사람 중 이름, 입사일, 부서번호를 출력하라 
	
	MariaDB [python_schema]> select ename, hiredate, deptno from emp where empno=7369;

(3) 이름이 ALLEN 인 사람의 모든 정보를 출력하라 
    
	MariaDB [python_schema]> select * from emp where ename="ALLEN";
	
	
(4) 입사일이 81/05/01 인 사원의 이름, 부서번호, 월급을 출력하라 
	
	MariaDB [python_schema]> select ename, deptno, sal from emp where hiredate="1981-05-01";

(5) 직업이 MANAGER 가 아닌 사람의 모든 정보를 출력하라 
    
	MariaDB [python_schema]> select * from emp where job!="MANAGER";
	
(6) 입사일이 81/04/02 이후에 입사한 사원의 정보를 출력하라 
    
	MariaDB [python_schema]> select * from emp where hiredate > "1981-04-02";

(7) 급여가 $800 이상인 사람의 이름, 급여, 부서번호를 출력하라 
    
	MariaDB [python_schema]> select ename, sal, deptno from emp where sal >=800;
    
(8) 부서번호가 20번 이상인 사원의 모든 정보를 출력하라 
    
	MariaDB [python_schema]> select * from emp where deptno>=20;

(9) 이름이 K로 시작하는 사람보다 높은 이름을 가진 사람의 이름을 출력하라 
    
    MariaDB [python_schema]> select ename from emp where ename>"K";
	
(10) 입사일이 81/12/09 보다 먼저 입사한 사람들의 모든 정보를 출력하라 
    
	MariaDB [python_schema]> select * from emp where hiredate < "1981-12-09";
	
(11) 입사번호가 7698보다 작거나 같은 사람들의 입사번호와 이름을 출력하라
    
    MariaDB [python_schema]> select empno, ename from emp where empno<=7698;
	 
(12) 입사일이 81/04/02 보다 늦고 82/12/09 보다 빠른 사원의 이름, 월급, 부서번호, 입사번호를 출력하라 
    
	MariaDB [python_schema]> select ename, sal, deptno, empno from emp where hiredate>"1981-04-02" and hiredate<"1981-12-09"

(13) 급여가 1,600 보다 크고 $3,000 보다 작은 사람의 이름, 직업, 급여를 출력하라 
    
	 MariaDB [python_schema]> select ename, job, sal from emp where sal>1600 and sal<3000;

(14) 사원번호가 7654와 7782 사이 이외의 사원의 입사번호, 이름을 출력하라 
    
	 MariaDB [python_schema]> select deptno, ename from emp where empno between 7654 and 7782;

(15) 이름이 B와 J사이의 모든 사원의 이름을 출력하라 
    
	 MariaDB [python_schema]> select ename from emp where ename between "B" and "J";

(16) 입사일이 81년 이외에 입사한 사람의 입사일과 이름를 출력하라 
    
	MariaDB [python_schema]> select hiredate, ename from emp where hiredate not like '1981%';
    
(17) 직업이 MANAGER와 SALESMAN인 사람의 이름과 직업을 출력하라 
    
	MariaDB [python_schema]> select ename, job from emp where job="MANAGER" or job="SALESMAN";
     
(18) 부서번호가 20, 30번을 제외한 모든 사람의 이름, 사원번호, 부서번호를 출력하라 
     
	MariaDB [python_schema]> select ename, empno, deptno from emp where deptno not in (20, 30);

(19) 이름이 S로 시작하는 사원의 사원번호, 이름, 입사일, 부서번호를 출력하라 
     
	MariaDB [python_schema]> select empno, ename, hiredate,deptno from emp where ename like 'S%';
	
(20) 입사일이 81년도인 사람의 입사일, 이름을 출력하라 
    
	MariaDB [python_schema]> select hiredate, ename from emp where hiredate like '1981%';
	
(21) 이름 중 A자가 들어가 있는 사람만 입사번호, 이름을 출력하라 
    
	MariaDB [python_schema]> select empno, ename from emp where ename like '%A%';

(22) 이름이 S로 시작하고 마지막 글자가 T인 사람의 이름을 출력하라 
    
	MariaDB [python_schema]> select ename from emp where ename like 'S%T';

(23) 이름의 두 번째 문자가 A인 사람의 이름을 출력하라 
    
	MariaDB [python_schema]> select ename from emp where ename like '__A%';
	
	 cf) 이름의 세 번째 문자가 A인 사람의 이름을 출력하라 
        MariaDB [python_schema]> select ename from emp where ename like '___A%';

(24) 커미션이 NULL인 사람의 이름과 커미션을 출력하라 
    
	MariaDB [python_schema]> select ename, comm from emp where comm is NULL;

(25) 커미션이 NULL이 아닌 사람의 이름과 커미션을 출력하라 
    
	MariaDB [python_schema]> select ename, comm from emp where comm is not NULL;

(26) 부서번호가 30번 부서이고, 급여가 $1,500 이상인 사람의 이름, 부서번호, 월급을 출력하라
    
	MariaDB [python_schema]> select ename, deptno, sal from emp where deptno=30 and sal>=1500;

(27) 이름의 첫 글자가 K 로 시작하거나 부서번호가 30인 사람의 사원번호, 이름, 부서번호를 출력하라 
    
	MariaDB [python_schema]> select empno, ename, deptno from emp where ename like 'K%' or deptno=30;
	
(28) 급여가 $1,500 이상이고, 부서번호가 30번인 사원 중 직업이 
      MANAGER인 사람의 급여, 부서번호, 직업을 출력하라 
    
	MariaDB [python_schema]> select sal, deptno, job from emp where sal>=1500 and deptno=30 and job="MANAGER";

(29) 부서번호가 30인 사람의 이름,사원번호,부서번호를 사원번호로 오름 SORT(정렬)하라
    
	MariaDB [python_schema]> select ename,empno,deptno from emp where deptno=30 order by empno;
      
(30) 이름과 급여의 데이터를 급여가 많은 순으로 SORT 하라 
    
	MariaDB [python_schema]> select ename, sal from emp order by sal desc;

(31) 부서번호로 ASCENDING SORT한 후 급여가 많은 사람 순으로 이름, 부서번호, 급여를 출력하라 
    
	MariaDB [python_schema]> select ename,deptno,sal from emp order by deptno asc, sal desc;
	
(32) 부서번호를 DESCENDING SORT한 후, 직업 순으로 ASCENDING SORT, 급여 순으로 DESCENDING SORT하라  
	
	MariaDB [python_schema]> select * from emp order by deptno desc, job asc, sal desc;

Tip) 문제의 해석이 모호할 때는 XXX 
   경우1) 만약 A라 B를 의미한다면.. 
      SQL1> ... 

   경우2) 만약 A라 C를 의미한다면..
      SQL2> ... 
     
     