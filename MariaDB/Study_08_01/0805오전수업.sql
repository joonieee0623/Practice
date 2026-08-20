< 함수(Function) >
어떤 '일'을 수행하는 기능으로써 주어진 인수(argument)를 재료로 '처리'하여,
그 결과를 'return'하는 일 --무조건 return값이 있어야 함

< 기능에 따른 분류 >
1) Data 계산
2) Data 변환

< 행에 따른 분류 >
1) 단일행 함수 ( ex: nvl, .. )
   -> 하나의 행당(row)당, 하나의 결과값을 리턴하는 함수
2) 복수행 함수( ex: max, min, avg, .. )
   -> 여러개의 행(row)당, 하나의 결과값을 리턴하는 함수

[ 단일행 함수 ]
: 
[1] 문자함수
(1) chr
select chr(65);

(2) concat
select ename, job from emp;
select concat(ename, ' is a ' , job) from emp;

(3) lower
select lower('MY NAME IS SOO');
select lower(ename) from emp;

(4) upper
select upper('my name is soo');
select upper(lower(ename)) from emp;

(5) trim 과 length
select '    Hello world     ';
select length('    Hello world     ');
select trim('    Hello world     ');
select length(trim('    Hello world     '));

(6) ltrim
select length(ltrim('  Hello World     '));

(7) rtrim
select length(rtrim('  Hello World     '));

(8) replace
select replace('JACK and JUE', 'J', 'BL');
select replace(dname, 'A', 'a') from dept;

(9) substr 또는 substring
select substr('ABCDEFGHIJ', 3, 2); --CD

-- ename의 두번째 자리가 'A'인 사원의 이름을 출력
select ename from emp where ename like '_A%';
SELECT ename FROM emp WHERE substr(ename, 2, 1) = 'A';

(10) ascii
select ascii('A'); --65
select ascii('a'); --97
select ascii(' '); --32
select ascii('3'); --51
select ascii('#'); --35

(11) greatest
select greatest('CC', 'ABCDE', 'CA');
select greatest('12', '132', '119');
select greatest('가나', '가다', '가자');

(12) nvl
select ename, comm from emp;
select ename, nvl(comm, -1) from emp;
select ename, comm from emp;

[2] 숫자 함수
(1) abs
select abs(-10); --거리
(2) ceil
select ceil(11.012); -- 12
select ceil(-11.012); -- -11
(4) floor
select floor(11.999); -- 11
select floor(-11.999); -- -12
(5) round
select round(12.5); -- 13
select round(-12.5); -- -13
(6) cos
select cos(90*3.141592/180); --0에 수렴
(7) sin
select sin(90*3.141592/180); --1에 수렴
(8) tan
select tan(45*3.141592/180); --1에 수렴
(9) log
select log(10, 100); --2
(10) mod
select mod(11, 4); --3
(11) power
select power(2, 50);
select power(2, 50)/(100*100*1000);
-- 신문지를 50번 접으면 그 두께가 얼마일까? ( 단 100장 1cm )
(12) truncate
select truncate(15.789, 2);
select truncate(15.789, 0);
select truncate(-15.789, 2);

[3] 날짜함수
(1) sysdate() 또는 now()
select sysdate();
select now();

(2) date_add
select HIREDATE from EMP where EMPNO=7782;
select HIREDATE, date_add(HIREDATE, interval 7 month) from EMP where EMPNO=7782;

(3) last_day
select str_to_date('26/8/05', '%y/%m/%d');
select last_day(str_to_date('26/8/05', '%y/%m/%d'));
select hiredate, last_day(hiredate) from emp;

<복수행 함수(Group Function)>
:
1. count
사원 수를 출력
select count(empno) from emp;  -- 14
select count(*) from emp;  -- 14
select count(comm) from emp;  -- 4 (NULL값 때문) 사용x
desc emp; -- empno에 pri이 걸려있는 걸 확인

2. sum
모든 사원의 급여 총합 출력
select sum(sal) from emp;
select sum(comm) from emp; --NULL은 제외됨

3. average
평균 급여와 평균 커미션 출력
select avg(sal) from emp;
select avg(comm) from emp; -- 4로 나눔. NULL은 제외됨
select avg(nvl(comm,0)) from emp; -- 14로 나눔

4. var_samp  -- 분산

 1  5  2  4  -> 합12, 평균3
 3  3  3  3 
-------------
-2  2 -1  1  -> 합0
-------------
 4  4  1  1  -> 분산

select var_samp(comm) from emp;

5. stddev_samp  --표준편차
select stddev_samp(comm) from emp;
select stddev_samp(nvl(comm,0)) from emp;

6. max 와 min
select max(sal) from emp;
select min(sal) from emp;
select max(sal)-min(sal) from emp;

최저 급여자의 사원이름과 급여를 출력
select ename, sal from emp where sal =(select min(sal) from emp);
select ename, sal from emp where sal = min(sal); -- X 그룹함수는 where절에서 단독으로 X

<Question>

1) 부서별 평균 급여를 출력(단, 소수점이하는 반올림)
select * from emp;

select deptno, avg(sal) sal from emp where deptno=10
union
select deptno, avg(sal) sal from emp where deptno=20
union
select deptno, avg(sal) sal from emp where deptno=30;

select deptno, round(avg(sal)) from emp group by deptno; --'별' group by

2) 급여 2000 이상인 사원들의 부서별 평균 급여의 반올림값 출력(부서번호의 오름차순 정렬)

select deptno, round(avg(sal)) from emp 
where sal>=2000 group by deptno order by deptno;

3) 급여 2000 이상인 사원들의 부서별 평균 급여의 반올림값 출력(평균 급여가 높은 순 정렬)

select deptno, round(avg(sal)) from emp 
where sal>=2000 group by deptno order by avg(sal) desc;

select deptno, round(avg(sal)) from emp 
where sal>=2000 group by deptno order by round(avg(sal)) desc; --order by 에서 round 빼도 됨
--먼저 수행 되는 것에 round 주면 마지막으로 실행되는 order by 에는 생략 가능

select deptno, round(avg(sal)) 평균급여 from emp 
where sal>=2000 group by deptno order by 평균급여 desc;

select deptno, round(avg(sal)) from emp 
where sal>=2000 group by deptno order by 2 desc;

4) 급여 1000이상인 사원들의 부서별 평균급여의 반올림값을 부서번호로 내림차순 정렬(단, 부서별 평균급여가 2000이상인 값만 출력)

select deptno, round(avg(sal)>=2000) from emp 
where sal>=1000 group by deptno order by deptno desc;
--- 오답. 내가 푼 것 ... 0과 1로 출력됨

select deptno, round(avg(sal)) from emp
where sal>=1000 group by deptno having avg(sal)>=2000 order by deptno desc;

select deptno, round(avg(sal)) 평균급여 from emp
where sal>=1000 group by deptno having 평균급여>=2000 order by deptno desc;

select deptno, round(avg(sal)) 평균급여 from emp
where sal>=1000 group by deptno having 평균급여>=2000 order by 1 desc;
---- index column 로 사용해 됨 deptno가 1번 index

5) 급여 1000이상인 사원들의 부서별 평균급여의 반올림값을 부서번호로 내림차순 정렬(단, 부서번호가 20이상인 값만 출력)

select deptno, round(avg(sal)) from emp
where sal>=1000 group by deptno having 1>=20 order by 1 desc;
--- 오답. 이건 왜 안나올까?

select deptno, round(avg(sal)) from emp
where sal>=1000 group by deptno having deptno>=20 order by deptno desc;

6) 각 부서별 같은 업무를 하는 사원의 인원수를 구하여 부서번호, 업무명, 인원수를 출력(단, 부서번호와 업무령을 각각 내림차순 정렬)

select deptno, job, count(empno) from emp
where group by job, deptno order by deptno desc, job desc;
--- 오답. 내가 푼 것
select deptno, job, count(empno) from emp
group by deptno, job order by deptno desc, job desc;

<일반화>
1. 순서 -- 매우 중요
  'SF-WGHO'
2. 그룹함수는 where절에 단독으로 나올 수 없음
