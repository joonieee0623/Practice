SQL (DDL·DML·DQL·DCL·TCL 종합)

**문제 1.다음 중 테이블 자체를 완전히 삭제하는 명령어는?
DROP
> **해설:** `DELETE`는 데이터의 일부/전체 행만 지우고 테이블 구조는 남아요. 
`TRUNCATE`도 데이터만 지우고 구조는 남아요. 
`ALTER`는 구조를 수정만 해요. 테이블 자체(구조+데이터)를 통째로 없애는 건 `DROP`뿐이에요.

**문제 2.
`TR_MEMBER` 테이블에서 이름이 '김철수'인 사람의 나이를 25로 바꾸는 SQL을 작성하시오.

update TR_MEMBER set 나이 = 25, where 이름 = '김철수';
--where 을 빼면 모든 사람의 나이가 바뀌니 주의

**문제 3.
다음 중 실행 즉시 자동으로 커밋(확정)되어 롤백이 불가능한 명령어 종류는? 
 DDL 
`CREATE`, `ALTER`, `DROP`, `TRUNCATE` 같은 DDL은 실행되는 순간 자동 커밋돼요. 
반면 `INSERT`, `UPDATE`, `DELETE` 같은 DML은 `COMMIT`을 해야 확정되고, 그 전엔 `ROLLBACK`으로 취소할 수 있어요.

**문제 4.
사용자 'lee'에게 `학교DB.학생` 테이블에 대한 SELECT 권한을 주는 SQL을 작성하시오.

grant select on 학교DB.학생 to 'lee'@'localhost';
문법: `GRANT 권한 ON DB명.테이블명 TO 사용자;`

**문제 5.
트랜잭션 도중 특정 지점까지만 되돌리고 싶을 때 사용하는 명령어는?
 SAVEPOINT** (되돌릴 때는 `ROLLBACK TO 저장점명`을 함께 사용)
> **해설: `SAVEPOINT sp1;`로 체크포인트를 찍어두고, 나중에 `ROLLBACK TO sp1;`을 하면 그 지점까지만 되돌아가요.
처음부터 전부 취소하고 싶으면 그냥 `ROLLBACK;`을 쓰면 돼요.

**문제 6.
`학생` 테이블에서 나이가 20살 이상인 사람의 이름과 나이를, 나이가 많은 순서로 조회하는 SQL을 작성하시오. 
DQL
select 이름, 나이 from 학생
where 나이 >= 20
order by 나이 desc;

**문제 7.
다음 중 데이터의 내용(값)은 그대로 두고, 테이블의 구조(컬럼)만 바꾸는 명령어는?
 ALTER
`UPDATE`는 값을 바꾸는 DML, `TRUNCATE`는 데이터를 지우는 DDL이에요. 
컬럼을 추가/삭제/변경하는 "구조 변경"은 `ALTER`가 담당해요.

**문제 8.
아래 SQL을 실행한 순서(사람이 읽고 이해하는 논리적 순서)대로 번호를 나열하시오.
```sql
SELECT 이름 FROM 학생 WHERE 나이 >= 20 ORDER BY 이름;
from -> where -> select -> order by
QL은 "쓰는 순서"와 "실제 처리되는 순서"가 달라요.
먼저 어느 테이블에서(FROM), 조건에 맞는 행을 거르고(WHERE), 필요한 컬럼만 뽑아서(SELECT), 마지막으로 정렬(ORDER BY)

**문제 9.
회원 테이블에서 나이가 NULL(비어있음)인 사람들을 모두 삭제하는 SQL을 작성하시오.
delete from 회원 where 나이 is null;
NULL은 값이 "없는" 상태라서 `= NULL`로는 비교가 안 돼요 (항상 결과가 없음 취급). 
반드시 `IS NULL` (있음: `IS NOT NULL`)을 써야 해요.

**문제 10.
`학생` 테이블을 완전히 삭제하지 않고, 안에 있는 데이터만 전부 빠르게 비우고 싶다. 알맞은 명령어는?
`TRUNCATE TABLE 학생;`
`TRUNCATE`는 테이블의 "틀"은 남기고 내용물만 통째로 비워요.
`DELETE`도 조건 없이 쓰면 전체가 지워지지만, 한 행씩 삭제 기록을 남기며 지우기 때문에 훨씬 느리고,
오토인크리먼트 번호도 초기화되지 않아요. `DROP`은 틀까지 없애버리므로 이 문제엔 맞지 않아요.

