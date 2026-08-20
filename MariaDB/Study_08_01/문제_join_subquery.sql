< 문제 (JOIN & SUB-QUERY) >

(1) EMP와 DEPT TABLE을 JOIN하여 부서번호, 부서명, 이름, 급여를 출력하라.
	select d.deptno, d.dname, e.ename, e.sal from emp e join dept d on e.deptno=d.deptno;
(2) 이름이 'ALLEN'인 사원의 부서명을 출력하라.
	select d.dname from emp e join dept d on e.deptno=d.deptno
	where e.ename='ALLEN';
(3) EMP Table에 있는 DATA와 JOIN하여 모든 사원의 이름, 부서번호, 부서명, 급여를 출력하라.
	select e.ename, e.deptno, d.dname, e.sal from emp e join dept d on e.deptno=d.deptno;
(4) EMP Table에 있는 EMPNO와 MGR을 이용하여 서로의 관계를 다음과 같이 출력하라.
	select concat(e.ename, "의 매니저는 ", m.ename) as 관계 from emp e join emp m on e.mgr=m.empno;
(5) 'ALLEN'의 직무와 같은 사람의 이름, 부서명, 급여, 직무를 출력하라.
	select e.ename, d.dname, e.sal, e.job from emp e join dept d on e.deptno=d.deptno
	where e.job=(select job from emp where ename='ALLEN');
(6) 'JONES'가 속해있는 부서의 모든 사람의 부서번호, 사원번호, 이름, 입사일, 
   급여를 출력하라.
	select deptno, empno, ename, hiredate, sal from emp where deptno=(select deptno from emp where ename='JONES');
(7) 전체 사원의 평균임금보다 많은 사원의 사원번호, 이름, 부서명, 입사일, 지역, 
    급여를 출력하라. 
	select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal from emp e join dept d on e.deptno=d.deptno
	where e.sal>(select avg(sal) from emp);
(8) 10번 부서 사람들 중에 20번 부서의 사원과 같은 업무를 하는 사원의 사원번호, 
    업무, 이름, 부서명, 입사일, 지역을 출력하라. 
	select e.empno, e.job, e.ename, d.dname, e.hiredate, d.loc from emp e join dept d on e.deptno=d.deptno
	where e.deptno=10 and e.job in(select job from emp where deptno=20);
(9) 10번 부서중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 업무, 
    이름, 부서명, 입사일, 지역을 출력하라.
	select e.empno, e.job, e.ename, d.dname, e.hiredate, d.loc from emp e join dept d on e.deptno=d.deptno
	where e.deptno=10 and e.job not in(select job from emp where deptno=30);
(10) 10번 부서와 같은 일을 하는 사원의 사원번호, 업무, 이름, 부서번호, 부서명, 
   지역, 급여를 급여가 많은 순으로 출력하라.
	select e.empno, e.job, e.ename, d.deptno, d.dname, d.loc, e.sal from emp e join dept d on e.deptno=d.deptno
	where e.job in(select job from emp where deptno=10)
	order by e.sal desc;
(11) 'MARTIN'이나 'SCOTT'의 급여와 같은 사원의 사원번호, 이름, 급여를 출력하라.
	select empno, ename, sal from emp 
	where sal in(select sal from emp where ename in('MARTIN','SCOTT'));
(12) 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호, 이름, 급여를 출력하라.
	select empno, ename, sal from emp
	where sal>(select max(sal) from emp where deptno=30);
(13) 급여가 30번 부서의 최저 급여보다 낮은 사원의 사원번호, 이름, 급여를 출력하라.
	select empno, ename, sal from emp
	where sal>(select min(sal) from emp where deptno=30);
 