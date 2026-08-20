1. join
--1) 정의 : 하나의 테이블로는 원하는 결과를 가져올 수 없는 경우, 관련된 테이블을 '논리적 결합'하여 원하는 컬럼정보를 가져오는 방법
--2) 조건 : 논리적으로 결합되는 2개 이상의 테이블에는 반드시 ***공통컬럼이 존재해야하며, 이 공통컬럼은 '동일한 데이터 타입'과 '동일한 데이터를 의미'해야 함
--	'공통컬럼'의 이름은 다를 수 있음(문법적으로 가능하지만, 좋지 않음(의미가 헷갈릴 수 있음))
--3) ex : 
--사원번호와 부서이름 출력하라
desc emp;
desc dept;
--table이 서로 관련?? 관계되는 공동 분모??
--공통 column이 있음!! => deptno 
--2개의 table에서 먼저 존재해야 하는게 뭘까?
select * from emp;  ---자식
select * from dept; ---부모 
--Entity(table)
--dept table이 먼저 존재해야 함(부모 entity)
--dept table에 제약 조건(pri)은 deptno에 있음
desc dept;
desc emp; --에서 deptno에 'MUL'이 걸려있다 
--부모 엔티티에는 반드시 unique한 게 있어야...
--각각 table에 pri가 걸려있다 하나도 없을 수도 있음. 여기는 한개 씩 걸렸고, emp엔 mul도 걸려있음 
--> 뜻: 부모table에 pri 참조 가능 / 부모table에 pri가 걸려있지 않는 것은 참조x

--답
select emp.empno, dept.dname from emp, dept; -- 14*4 56개 나옴 이걸 원하는게 아님-> 조건 걸어
----앞에 emp.는 엔티티 empno는 속성
--형태 1
select emp.empno, dept.dname from emp, dept 
	where emp.deptno=dept.deptno dept.deptno=30;  --14rows in set

select emp.empno, dept.dname from emp, dept
  where emp.deptno=dept.deptno and dept.deptno=30;

--형태 2
select empno, dname from emp, dept 
	where emp.deptno=dept.deptno and dept.deptno=30;  --간결하게 생략(거기에만 있어서)

select empno, dname from emp, dept
  where emp.deptno=dept.deptno and dept.deptno=30;
--형태 
select emp.empno, dept.dname from emp e, dept 
	where emp.deptno=dept.deptno amd d.deptno=30;
---from문이 가장 먼저 인식돼서 알리아스를 거기에 주면 다 적용된다

--형태 3
select e.empno, d.dname from emp e, dept d
  where e.deptno=d.deptno and d.deptno=30;

--형태 4
select empno, dname from emp e, dept d
  where e.deptno=d.deptno and d.deptno=30;

--형태 5
select empno, dname from emp e join dept d
	on e.deptno=d.deptno where d.deptno=30;


--'SF-WGHO' 에서 가운데 - : 대표적인 것이 join

--alias

< 조인(join) >

1. 정의
하나의 테이블로는 원하는 결과를 가져올 수 없는 경우,
관련된 테이블들을 '논리적 결합'하여 원하는 컬럼정보를 가져오는 방법

2. 조건
논리적으로 결합되는 2개 이상의 테이블에는 반드시 '공통컬럼'이 존재해야하며
이 공통컬럼은 '동일한 데이터 타입'과 '동일한 데이터를 의미'해야 함

-- 사원번호와 부서이름을 출력하라
select emp.empno, dept.dname from emp, dept where emp.deptno=dept.deptno;
select empno, dname from emp, dept where emp.deptno=dept.deptno;

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