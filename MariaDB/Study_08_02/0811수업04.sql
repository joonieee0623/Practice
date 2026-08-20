3. 정규화 비정규화
 (1) 정규화(Nprmalization)
   1) 1정규화 : '한컬럼'에 여러개의 속성값을 넣지마!
     ex) <고객>
        연락처 : 번호1, 번호2, ...
   2) 2정규화 : 일반컬럼은 'PK컬럼들 전체에 종속' 돼야 해!
     ex) <주문>
        PK[손님ID+상품ID] / 고객주소(X)
	--고객주소는 상품ID와는 관련X, 손님ID와는 관련O
	--(주문TABLE이 아닌 손님TABLE에 있어야 함(관련))
   3) 3정규화 : '일반컬럼끼리는 종속' 관계가 있으면 안돼!
     ex) <주문>
       PK[주문번호] / 고객번호(O), 고객명(X)


 (2) 비정규화(Denormalization)
  - 간단하고 빠른 SELECT문을 위해 정규화된 일부 테이블 '합치기'
    ('중복'과 '널'은 일부 허용)
  - '추가 테이블' 생성 ex. 매출결산 및 통계


4. 단계(STEP)
  (1) Solution 제작 순서
    1) 현실세계의 '업무분석' / '요구사항'
    2) '개'념적 모델링(PPT, txt,...)
    3) '논'리적 모델링(diagram with tool) ERD
    4) '물'리적 모델링(diagram with tool)
    5) SQL 생성
    6) 구현(UI디자인(FRONT) + 프로그램(BACK))
    7) 테스팅
    8) 배포 / 서비스(유지보수)

  (2) DB 모델링 순서
    1) 업무분석표 / 요구분석서
    2) '개'념적 모델링
       '엔티티', '속성', '관계'를 추출해서 개념적 문서를 정의하는 단계
       ex) N : N
        학생 [학번(PK), 이름, 주소, 연락처]
	 |
	등록 [등록번호(PK), 학번(FK), 과목번호(FK), 등록일자]
	 |
	과목 [과목번호(PK), 
    3) '논'리적 모델링
	개념적 모델링단계에서 정의된 ERD(Entity Relationship Diagram)를 매핑룰을
	적용해서 스키마를 생성하고 '정규화'까지를 포함하는 단계
	( 스키마는 개체들의 관계 제약조건등의 명세를 포함한 '데이터 구조들' )
	  ex) ERD
    4) '물'리적 모델링
	논리적 모델링에서 작성된 내용을 토대로 'DBMS를 결정',
	'컬럼타입과 사이즈'를 정의, 각 종 '제약조건'(CHECK, NOT NULL, PK, FK, UNIQUE),
	인덱스등을 정의하여 '역정규화'까지를 포함하는 단계
	ex) ERD
    5) SQL / PLSQL
	1> create.sql
	2> drop.sql
	3> insert.sql
	4> select.sql('요구사항'을 기준으로 작성)

  (3) Crow's Foot Notation 표기
    1) 표기
      1> 실선 : '식별'관계
      2> 점선 : '비식별'관계
      3> 0 : 선택 Optional
      4> | : 필수 Mandatory -> 1개가 되어야 함
      5> 까마귀다리 : Many -> 여러 개가 될 수 있음
    2) 관계 관점('자식' 테이블측)
      <1> Cardinality
        1> Zero, ( One or) Many
	2> One or Many
	3> Zero or One
	4> One
	5> Many
      <2> Relationship Type
        1> Identifying: 실선
	2> Non-Identifying: 점선
   (4) ERD로 해야 할 모델링
     1) '논'리적 모델링
       DBMS가 정해지지 않은 상태에서의 ERD
     2) '물'리적 모델링
       DBMS이 정해져서 해당 DBMS에 적합한 '테이블이름'과
       '컬럼', '데이터타입/사이즈'를 모두 '영문'으로 바꾼 ERD
    (5) SQL(DDL + DML + DQL) 작성
    (6) 모델링툴(eXERD) 사용
       - Forward Engineering(ERD -> SQL)
       - Reverse Engineering(SQL -> ERD)


- 가맹점별 관리(본사X) 독립적 운영
tiger@daum.net(영등포)
tiger@daum.net(성남)
회원 == 돈


