-- 사원번호가 7900인 사원의 부서이름 출력
(1) 조인
select dname from emp natural join dept where empno=7900;

(2) 서브쿼리
  Sub> select deptno from emp where empno=7900;
  Main> select dname from dept where deptno=30;
  결합> select dname from dept where deptno=(select deptno from emp where empno=7900);

  1) 정의
    하나의 select문장에 포함된 또 다른 select문장
    ( 두번 이상 질의를 해야 얻을 수 있는 결과를 한번의 질의로 통합한 쿼리 )

  2) 용어
    Main-Query or Outer-Query or 주
    Sub-Query or Inner-Query or 서브

  3) 특징
    <1> '소괄호'를 묶어야 함
    <2> '실행순서'는 '대부분' Sub-Query가 먼저 수행되고, Main-Query가 수행됨
    <3> Sub-Query는 Main-Query의 다음 부분에 위치할 수 있음
     - select/delete/update 문장의 from 절 / where 절
     - insert 문장의 into 절
     - update 문장의 set 절
    <4> Sub-Query는 order by 절 사용 불가!
     ( 예외: select/delete/update 문장의 from 절 )

  4) 종류
    <1> 단일행 Sub-Query
        실행결과가 '하나의 데이터'만 리턴해주는 쿼리

	-- 평균급여보다 많은 받는 사원의 '이름과 급여' 출력!
	시도> select ename, sal from emp where sal>avg(sal); --(X)
	Sub> select avg(sal) from emp; --단일행
	Main> select ename, sal from emp where sal>(select avg(sal) from emp);

    <2> 복수행 Sub-Query
        실행결과가 '둘 이상의 데이터 행'을 리턴해주는 쿼리

	-- 부서번호가 10번인 사원급여와 급여가 같은 사원의 이름과 급여를 출력
	Sub> select sal from emp where deptno=10; --복수행
	Main> select ename, sal from emp where sal=(select sal from emp where deptno=10); --(X)
	
	해결> select ename, sal from emp where sal in(select sal from emp where deptno=10);
	해결> select ename, sal from emp where sal=any(select sal from emp where deptno=10);
	효과> select ename, sal from emp where sal=2450 or sal=5000 or sal=1300;

        -- (급여가 가장 많은) 'MANAGER'보다 급여가 같거나 많은 사원의 JOB,SAL을 출력!!
	Sub> select sal from emp where job='MANAGER';
	Main> select job, sal from emp where sal>=(select sal from emp where job='MANAGER'); --(X)

	해결> select job, sal from emp where sal>=all(select sal from emp where job='MANAGER');
	효과> select job, sal from emp where sal>=2975 and sal>=2850 and sal>=2450;

    <3> 복수컬럼 Sub-Query
	실행결과가 '둘 이상의 컬럼'데이터를 리턴해주는 쿼리

	--'부서번호'가 30인 사원의 (SAL과 COMM)이 같은 사원들의 '이름'과 '부서번호' 출력!
	Sub> select sal, comm from emp where deptno=30;
	Main> select ename, deptno from emp where sal in (select sal, comm from emp where deptno=30); --(X)

	해결> select ename, deptno from emp where (sal, comm)
	    in (select sal, comm from emp where deptno=30);
	비교> select ename, deptno from emp where (sal, nvl(comm,0))
	    in (select sal, nvl(comm,0) from emp where deptno=30);

    <4> 상호관련 Sub-Query
        Main-Query 절에 사용된 테이블이 Sub-Query절에 다시 '재사용'되는 쿼리

	Sub1> select avg(e1.SAL) from EMP e1, EMP e2 where e1.DEPTNO=e2.DEPTNO;
	Sub2> select avg(e1.SAL) from EMP e2 where e1.DEPTNO=e2.DEPTNO;
	Main> select e1.empno, e1.sal from emp e1 where sal>=?
	결합> select e1.empno, e1.sal from emp e1
	where sal>=(select avg(e1.SAL) from EMP e2 where e1.DEPTNO=e2.DEPTNO);