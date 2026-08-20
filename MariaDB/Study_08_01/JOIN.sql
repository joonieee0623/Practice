DDL
drop table if exists emp; --존재하면 삭제하라
drop table if exists dept;

--실행할 것
--기존꺼 남게..

drop table if exists emp2; 
drop table if exists dept2;

create table dept2(
	deptno int primary key,
	dname varchar(50) not null);


create table emp2(
	empno int primary key,
	ename varchar(50) not null
	deptno int, 
	foreign key(deptno) references dept(deptno));

show table;
--내용 없어, 넣어줘야 함

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
(105, '강준호', null);

select * from dept2;
select * from emp2;

source C:\Users\PC\Downloads\innerOuter.sql

---오늘 수업내용
1. inner join  --4개 검색
 select e.empno, e.ename, d.dname from emp2 e inner join dept2 d 
	on e.deptno=d.deptno;

2. outer join 
 1)left
 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno;
 
 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno where d.dname is null; --error

 2) right

 select e.empno, e.ename, d.dname from emp2 e right join dept2 d
	on e.deptno=d.deptno;

 3) full
 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno
	union all --중복 허용(중복허용 않는다면, union만)
 select e.empno, e.ename, d.dname from emp2 e right join dept2 d
	on e.deptno=d.deptno;

 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno
	union all 
 select e.empno, e.ename, d.dname from emp2 e right join dept2 d
	on e.deptno=d.deptno;

 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno
	union all 
 select e.empno, e.ename, d.dname from emp2 e right join dept2 d
	on e.deptno=d.deptno where e.empno is null;

 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno
	union
 select e.empno, e.ename, d.dname from emp2 e right join dept2 d
	on e.deptno=d.deptno;

 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno
	union
 select e.empno, e.ename, d.dname from emp2 e right join dept2 d
	on e.deptno=d.deptno where e.empno is null;

 select e.empno, e.ename, d.dname from emp2 e left join dept2 d
	on e.deptno=d.deptno
	union all 
 select e.empno, e.ename, d.dname from emp2 e right join dept2 d
	on e.deptno=d.deptno where e.empno is not null;