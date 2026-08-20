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

