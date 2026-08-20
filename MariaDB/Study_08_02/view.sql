
Q. 부서번호가 10번인 사원 평균급여 보다 급여가 적은 사원들의 부서별 평균 급여(단, 10번부서는 출력제외, 부서번호 역정렬, 급여는 반올림할 것)
 select deptno, round(avg(sal)) as 평균급여 from emp 
	where sal <(select avg(sal) from emp where deptno=10)
	and deptno!= 10
	group by deptno
	order by deptno desc;

 sub> select avg(sal) from emp where deptno=10;
 main> select deptno, round(avg(sal)) from emp
	where sal< ? --sub query 자리
	group by deptno
	having deptno!=10
	order by deptno desc;
 answer> select deptno, round(avg(sal)) from emp
	where sal<(select avg(sal) from emp where deptno=10)
	group by deptno
	having deptno!=10
	order by deptno desc;


--문제점
1) SQL이 길다
2) 개발자들에 공유
--> 이 때, view 사용

<VIEW>

 (1) :
   실제 테이블들을 참조해서 만들어진 가상(논리)테이블
 (2) ex
   1) 생성
	drop view if exists MY_VIEW;

	create view MY_VIEW as 
	select deptno, round(avg(sal)) from emp
	where sal<(select avg(sal) from emp where deptno=10)
	group by deptno
	having deptno !=10
	order by deptno desc;

   2) 확인
	desc MY_VIEW;
	select * from MY_VIEW order by deptno desc;
   
 (3) 모양
	create view 뷰이름 as
	 select 문...;

 (4) 특징
   1) 가상 테이블
   2) 읽기 전용 or 수정 가능
   3) 보안성(테이블 구조를 알 수 없음)
   4) 복잡한 쿼리를 단순화
   5) 실시간 반영
