< 조인(join) >

1. 정의
하나의 테이블로는 원하는 결과를 가져올 수 없는 경우,
관련된 테이블들을 '논리적 결합'하여 원하는 컬럼정보를 가져오는 방법

2. 조건
논리적으로 결합되는 2개 이상의 테이블에는 반드시 '공통컬럼'이 존재해야하며
이 공통컬럼은 '동일한 데이터 타입'과 '동일한 데이터를 의미'해야 함

-- 사원번호와 부서이름을 출력하라
select emp.empno, dept.dname from emp, dept where emp.deptno=dept.deptno;
select empno, dname from emp, dept where emp.deptno=dept.deptno; --생략
select e.empno, d.dname from emp e, dept d where e.deptno=d.deptno;  --alias 
select empno, dname from emp e, dept d where e.deptno=d.deptno; --생략
select empno, dname from emp e join dept d where e.deptno=d.deptno; --join
select empno, dname from emp e join dept d on e.deptno=d.deptno;
select empno, dname from emp join dept using(deptno); --join using
select empno, dname from emp natural join dept; --natural join 



3. 예 -- 사원번호와 부서이름을 출력
--형태1
select emp.empno, dept.dname from emp, dept
  where emp.deptno=dept.deptno and dept.deptno=30;
--형태2
select empno, dname from emp, dept
  where emp.deptno=dept.deptno and dept.deptno=30;
--형태3
select e.empno, d.dname from emp e, dept d
  where e.deptno=d.deptno and d.deptno=30;
--형태4
select empno, dname from emp e, dept d
  where e.deptno=d.deptno and d.deptno=30;
--형태5
select empno, dname from emp e join dept d
  on e.deptno=d.deptno where d.deptno=30;