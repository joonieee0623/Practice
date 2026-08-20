-- 사원번호와 부서이름을 출력하라
select emp.empno, dept.dname from emp, dept where emp.deptno=dept.deptno;
select empno, dname from emp, dept where emp.deptno=dept.deptno; --생략
select e.empno, d.dname from emp e, dept d where e.deptno=d.deptno;  --alias 
select empno, dname from emp e, dept d where e.deptno=d.deptno; --생략
select empno, dname from emp e join dept d where e.deptno=d.deptno; --join
select empno, dname from emp e join dept d on e.deptno=d.deptno;
select empno, dname from emp join dept using(deptno); --join using
select empno, dname from emp natural join dept; --natural join 


<Join  종류>
1. cross
   : 조건이 없는 조인
   ex)
   select e.empno, d.dname from emp e, dept d; --56(14*4)
   select count(*) from dept; --4
   select count(*) from empt; --14

2. natural 
   : (==equi)가장 일반적, '공통컬럼'들이 동등연산자(=)에 의해 비교되는 조인
   ex) --사원번호와 부서이름을 출력(단, 30번 부서만)
   select emp.empno, dept.dname from emp, dept
	where emp.deptno=dept.dname and dept.deptno=30;
   select empno, dname from emp, dept 
	where emp.deptno=dept.deptno and dept.deptno=30;
   select e.empno, d.dname from emp e, dept d 
	where e.deptno=d.deptno and d.deptno=30;
   select empno, dname from emp e, dept d 
	where e.deptno=d.deptno and d.deptno=30;
   select empno, dname from emp e join dept d 
	where e.deptno=d.deptno and d.deptno=30;
   select empno, dname from emp e join dept d 
	on e.deptno=d.deptno where d.deptno=30;
   select empno, dname from emp join dept using(deptno)
	where deptno=30;
   select empno, dname from emp natural join where deptno=30;


3. self
   : 가져와야 할 컬럼이 '자신의 테이블에 있는 다른 컬럼'인 경우의 조인
   ex) --SMITH의 MANAGER는 FORD다
   select * from emp; --를 보면 SMITH의 MGR가 FORD의 EMPNO임
   형태1)
    select e.ename, m.ename from emp e, emp m where e.mgr=m.empno;
    select e.ename 사원, m.ename 매니저 from emp e, emp m 
	where e.mgr=m.empno;
    select e.ename 사원, m.ename 매니저 from emp e, emp m 
	where e.mgr=m.empno and e.ename='SMITH';
    select e.ename 사원,"의 매니저는 ", m.ename 매니저 from emp e, emp m 
	where e.mgr=m.empno and e.ename='SMITH';
    ---
    SELECT CONCAT(e.ename, '의 매니저는 ', m.ename) AS 결과 FROM emp e
	JOIN emp m ON e.mgr = m.empno
	WHERE e.ename = 'SMITH';

   형태2)
    select e.ename, m.ename from emp e join emp m on e.mgr=m.empno;
    select e.ename 사원. m.ename 매니저 from emep e join emp m on e.mgr=m.empno;
    select e.ename 사원, m.ename 매니저 from emp e, emp m 
	on e.mgr=m.empno and e.ename='SMITH';
    select e.ename 사원, m.ename 매니저 from emp e join emp m 
	on e.mgr=m.empno where e.ename='SMITH';

4. inner
   :join되는 테이블에서 '공통데이터'들만 출력

5. outer
   :조인되는 한쪽 테이블에는 해당하는 데이터가 존재하고,
   다른쪽 테이블에는 테이터가 존재하지 않을 경우에 '기준테이블'을 이용한 조인

-------------------------------------------------
DDL
drop table if exists emp2;
drop table if exists dept2;

create table dept2(
    deptno int primary key,
    dname varchar(50) not null
);
create table emp2(
    empno int primary key,
    ename varchar(50) not null,
    deptno int,
    foreign key(deptno) references dept(deptno)
);

show tables;

insert into dept2 values
(10, '영업부'),
(20, '개발부'),
(30, '인사부'),
(40, '마케팅부');

insert into emp2 values
(101, '김철수', 10),
(102, '이영희', 20),
(103, '박민수', 10),
(104, '최지영', 20),
(105, '강준호', NULL);

select * from dept2;
select * from emp2;
-------------------------------------------------

-- (1) inner join  --4개 검색
select e.empno, e.ename, d.dname from emp2 e inner join dept2 d
on e.deptno=d.deptno;

-- (2) outer join
-- 1) left  -- 5개 검색
select e.empno, e.ename, d.dname from emp2 e left join dept2 d
on e.deptno=d.deptno;

-- 2) right
select e.empno, e.ename, d.dname from emp2 e right join dept2 d
on e.deptno=d.deptno;

-- 3) full
select e.empno, e.ename, d.dname from emp2 e left join dept2 d
on e.deptno=d.deptno

union all -- union OR union all

select e.empno, e.ename, d.dname from emp2 e right join dept2 d
on e.deptno=d.deptno
where e.empno IS NULL;

------------------------------------------------------------

--사원 번호가 7900인 사원의 부서이름 출력
1) 조인
select d.dname from emp e 
	join dept d on e.deptno= d.deptno 
	where e.empno= 7900;

select dname from emp natural join dept 
	where empno=7900;

2) 서브쿼리
--join 을 쓰지 않고 

select * from emp;    --먼저 실행해야 하는 쿼리 : SubQuery
select * from dept;

Sub> select deptno from emp where empno=7900;
Main> select dname from dept where deptno=30;
결합> select dname from dept where deptno=(select deptno from emp where empno=7900);

(1) 개념 : 하나의 select문장에 포함된 또 다른 select 문장
	(두 번 이상 질의를 해야 얻을 수 있는 결과를 한 번의 질의로 통합한 쿼리)

(2) 용어 :
	Main-Query or Outer-Query or 주
	Sub-Query or Inner-Query or 서브

(3) 특징 : 
	() 소괄호 묶어야 함
	실행순서는 *대부분 서브쿼리가 먼저 수행되고, 메인쿼리가 수행됨(항상x)
	ex)
	서브쿼리는 메인쿼리의 다음 부분에 위치할 수 있음
	- select/delete/update 문장의 from 절 / where 절
	- insert 문장의 into 절
	- update 문장의 set 절

	서브쿼리는 order by 절 사용 불가!
	예외 : select/delete/update 문장의 from 절

--오후
종류
1. 단일행 서브쿼리
 실행결과가 '하나의 데이터'만 리턴해주는 쿼리
 select deptno from emp where empno=7900; --1개

--평균 급여보다 많이 받는 사원의 '이름과 급여' 출력
 시도> select ename, sal form emp where sal>avg(sal); --error
 sub> select avg(sal) from emp; --단일행
 main> select ename, sal from emp where sal>(select avg(sal) from emp);
 
2. 복수행 서브쿼리 
 실행결과가 '둘 이상의 데이터 행'을 리턴해주는 쿼리
 select sal from emp where deptno=10; --data가 여러개

--부서번호가 10번인 사원급여와 급여가 같은 사원의 이름과 급여를 출력
 sub> select sal from emp where deptno=10; --복수행
 main> select ename, sal from emp where sal=(select sal from emp where deptno=10); --error

 --연산자 사용
 해결> select ename, sal from emp where sal in(select sal from emp where deptno=10);
 해결> select ename, sal from emp where sal=any(select sal from emp where deptno=10);
 효과> select ename, sal from emp where sal=2450 or sal=5000 or sal=1300;

 --(급여가 가장 많은) 'MANAGER'보다 급여가 같거나 많은 사원의 JOB, SAL을 출력
 sub> select sal from emp where job='MANAGER';
 main> select job, sal from emp where sal>=(select sal from emp where job='MANAGER'); --error

 해결> select job, sal from emp where sal>=all(select sal from emp where job='MANAGER');
 효과> select job, sal from emp where sal>=2975 and sal>=2850 and sal>=2450;
    > select job, sal from emp where sal>=(select max(sal) from emp where job='MANAGER');

 -- >=all (목록) : 목록의 최댓값보다 크거나 같음(가장 엄격)
 -- >=any (목록) : 목록 중 하나라도 그 값보다 크거나 같으면 됨(=최솟값보다 크거나 같음, 훨씬 느슨함)
 
3. 복수컬럼 서브쿼리
 실행결과가 '둘 이상의 컬럼' 데이터를 리턴해주는 쿼리
 select sal, comm from emp where empno=7499;

 --'부서번호'가 30인 사원의 (sal과 comm)이 같은 사원들의 '이름'과 '부서번호' 출력
 sub> select sal, comm from emp where deptno=30;
 main> select ename, deptno from emp where sal 
	in (select sal, comm from emp where deptno=30); --error

 해결> select ename, deptno from emp where (sal, comm) 
	in(select sal, comm from emp where deptno=30);
 비교> select ename, deptno from emp where (sal, nvl(comm,0)) 
	in(select sal, nvl(comm,0) from emp where deptno=30);

4. 상호관련 서브쿼리
 메인쿼리 절에 사용된 테이블이 서브쿼리 절에 다시 '재사용'되는 쿼리 (서로 연관이 있다)

 sub1> select avg(e1.sal) from emp e1, emp e2 where e1.deptno=e2.deptno;
 sub2> select avg(e1.sal) from emp e2 
	where e1.deptno=e2.deptno; --error e1이 정의가 되지 않았기 때문/독립적으로 실행x/메인쿼리에 의존
 main> select e1.empno, e1.sal from emp e1 
	where sal>=?
 결합> select e1.empno, e1.sal from emp e1 
	where sal>=(select avg(e1.sal) from emp e1, emp e2 where e1.deptno=e2.deptno);

