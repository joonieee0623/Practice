<DB Modeling(DB 설계)>

1. 개념 
 현실 세계의 업무(프로세스)를 분석해서 '실체(Entity)'를 도출하고,
 SW로 구현해내기 위한 '데이터 구조'를 작성하는 업무

2. Relation
 (1) 이해
   1) 고객
   이름   아이디   핸드폰   주소   차넘버   차종   차명   년식
  ----------------------------------------------------
  홍길동  aa     1234   서울   a1234  승용차  소나타  1995
  임꺽정  bb     2345   부산   NULL   NULL   NULL  NULL
  이승엽  cc     3456   대전   NULL   NULL   NULL  NULL
  한예슬  dd     4567   광주   d1234  승합차  갤로퍼  2001
  장동건  ee     5678   대구   NULL   NULL   NULL  NULL
  한예슬  dd     4567   광주   f1234  미니벤  카렌스  1998

   2) 정리 : L자 table 공간 차지 
    이름   아이디   핸드폰   주소   차넘버  차종   차명    년식
   ----------------------------------------------------
    임꺽정  bb    2345   부산   NULL   NULL  NULL   NULL
    이승엽  cc    3456   대전   NULL   NULL  NULL   NULL
    장동건  ee    5678   대구   NULL   NULL  NULL   NULL
    한예슬  dd    4567   광주   d1234  승합차  갤로퍼  2001
    홍길동  aa    1234   서울   a1234  승용차  소나타  1995
    한예슬  dd    4567   광주   f1234  미니벤  카렌스  1998

   3) table 분리 시도1 ('레코드(row)'기준) : 절대 row 기준 XXX
     1. 테이블1 (자동차 소유하지 않은 '고객')
	이름  아이디  핸드폰  주소
       ----------------------------
	임꺽정  bb   2345   부산
	이승엽  cc   3456   대전
        장동건  ee   5678   대구
     2. 테이블2 (자동차 소유한 '고객')
	이름  아이디  핸드폰   주소   차넘버  차종   차명  년식
       -----------------------------------------------
	한예슬  dd   4567   광주  d1234  승합차 갤로퍼 2001
	홍길동  aa   1234   서울  a1234  승용차 소나타 1995
        한예슬  dd   4567   광주  f1234  미니벤 카렌스 1998

   4) table 분리 시도2 ('column' 기준)
     1. 테이블1 ('고객') --부모table
	이름   아이디    핸드폰   주소
      ----------------------------
        임꺽정  bb     2345   부산
        이승엽  cc     3456   대전
	장동건  ee     5678   대구
	한예슬  dd     4567   광주
	홍길동  aa     1234   서울
	한예슬  dd     4567   광주

     2. 테이블2 ('자동차') --FK필요 : 공통컬럼 필요
	차넘버   차종    차명   년식
       ------------------------
	d1234  승합차  갤로퍼  2001
	a1234  승용차  소나타  1995
	f1234  미니벤  카렌스  1998

   5) 관계
     1.  '부모/자식' 관계 결정
       ex1) '사원'이 정의되기 위해서는, 먼저 '부서'가 정의되어야 한다
       ex2) '자동차'가 정의되려면, 먼저 '고객'이 정의되어야 한다

     2.  공통컬럼 요구
       '고객'table 의 아이디(PK)
       '자동차'table 의 아이디(FK)

     3. '부모/자식' 반대로 했을 경우(X)
       테이블2('자동차') --부모
	차넘버(PK) 차종   차명  년식
	----------------------------
	d1234   승합차 갤로퍼 2001
	a1234   승용차 소나타 1995
	f1234   미니벤 카렌스 1998

       테이블1('고객') --자식
         차넘버(FK)
	 이름  아이디(PK) 핸드폰   주소  차넘버(FK)
	---------------------------------------
	임꺽정  bb       2345   부산   NULL
	이승엽  cc       3456   대전   NULL
	장동건  ee       5678   대구   NULL
	한예슬  dd       4567   광주   d1234
	홍길동  aa       1234   서울   a1234
	한예슬  dd       4567   광주   f1234 --PK의 중복 발생
       
     4. '부모/자식' 바르게 설정
      1. 테이블1('고객') --부모
       이름  아이디(PK) 핸드폰   주소 
      --------------------------
       임꺽정  bb      2345   부산  
       이승엽  cc      3456   대전   
       장동건  ee      5678   대구   
       한예슬  dd      4567   광주   
       홍길동  aa      1234   서울   
     
      2. 테이블2('자동차') --자식
       차넘버(PK)  차종   차명  년식  아이디(FK) 
      -----------------------------------
	d1234	승합차 갤로퍼 2001   dd
	a1234   승용차 소나타 1995   aa 
	f1234   미니벤 카렌스 1998   dd
	
      3. 질의검증
	'홍길동'의 자동차의 차넘버를 SELECT 하라
	  Sub> select ID from MEMBER where NAME='홍길동';
	 Main> select m.NAME, c.NUM from Member m, Car c
	       where c.ID=(select ID from MEMBER where NAME='홍길동');
	

     5. 관계 종류
      1) Cardinality 관점
        1> (1:1) : 모델링 '가능'
	  ex) 부서/부서장
        2> (1:n) : 모델링 '가능'
	  ex) 부서/사원
	3> (n:n) : 모델링 '불가'
	  ex) 손님/상품
	      학생/동아리
	      학생/과목
	      공장/제품
	      ...
	      부모자식관의 관계X
	      # 다대다 관계의 '해소'
	      n:n은 1:n으로 변경('중간테이블 생성')해서 모델링해야 함
	      1> 테이블1('손님') --부모

	      2> 테이블2('상품') --부모

	      3> 테이블3(중간테이블 '구매') --자식

	    

      2) Relationship Type 관점
        1. 식별관계(Identifying)
	  1> 정의 : '부모의 PK'컬럼이 '자식의 PK'컬럼으로 전이되는 것
	          부모PK전달위치 = 자식의 PK + FK / 부모 없이 존재 불가(강한 의존)
	  2> 무조건 No nulls (: NOT NUll 필수)
	   ex) DEPT4/EMP4
	   

	2. 비식별관계(Non-Identifying)
	  1> 정의 : '부모의 PK'컬럼이 '자식의 일반'컬럼으로 전이되는 것
	          부모table의 PK를 자식table이 FK로만 가져가고, 그 FK를 자신의 PK에는 포함시키지 않는 관계
		  자식의 FK만 = 부모 없이도 존재 가능(약한 의존)
	  2> 2개 중 선택 
	     - Null Allowed
	     - No nulls
	   ex) DEPT5/EMP5

        3. 식별관계(DEPT4/EMP4)생성

	 drop table if exists DEPT4;

	    create table DEPT4(
	     no int primary key,
	     dname varchar(14) not null
	     loc varchar(14) not null
	    );

	    drop table if exists EMP4;

	    create table EMP4(
	     empno int(4) not null,
	     ename varchar(10) not null,
	     job varchar(9) not null,
	     mgr int(4) 
	     hiredate date default (current_date),
	     sal decimal(7,2) not null,
	     comm decimal(7,2),
	     deptno int not null,

	     primary key(empno, deptno),  --deptno가 PK 안에 들어가 있음(=부모PK가 자식PK로 전이 됐다)
	     foreign key(deptno) references dept4(no)
	    );  
	  
	   -- 식별관계 : 부모PK->자식의 PK일부
	   -- 비식별관계 : 부모PK -> 자식의 평범한 FK컬럼(PK엔 안 들어감, NULL허용 가능)

	    
        4. 비식별관계(DEPT5/EMP5)생성

