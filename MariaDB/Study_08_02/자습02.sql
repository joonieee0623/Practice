PL/SQL (절차형 SQL: 프로시저·함수·트리거·변수·제어문)

**문제 1.
프로시저/트리거를 만들기 전에 `DELIMITER $$`를 쓰는 이유는 무엇인가?
프로시저·트리거 본문 안에 세미콜론(`;`)이 여러 번 나오는데, 
기본 구분자인 `;`를 그대로 쓰면 DB가 "각 문장이 끝났다"고 착각해서 코드를 중간에서 잘라 실행해버려요.
그래서 임시로 구분자를 `$$` 등으로 바꿔서, `$$`가 나올 때까지를 하나의 덩어리로 인식하게 만드는 거예요. 
다 만든 후엔 `DELIMITER ;`로 원래대로 되돌려야 해요.

**문제 2.
다음 빈칸을 채워 변수 `cnt`를 정수형으로 선언하고 기본값 0을 주는 문장을 완성하시오.
```sql
declare cnt INT default 0;
```
값을 다시 바꿀 땐 `SET cnt = 값;`

**문제 3.
점수가 90점 이상이면 'A', 80점 이상이면 'B', 그 외에는 'F'를 `학점` 변수에 넣는 IF문을 작성하시오.
if 점수 >= 90 then
 set 학점 = 'A'
elseif 점수 >= 80 then
 set 학점 = 'B'
else
 set 학점 = 'F'
end if;

**문제 4.
프로시저(PROCEDURE)와 함수(FUNCTION)의 가장 큰 차이점 한 가지를 설명하시오.
 함수는 반드시 `RETURN`으로 값을 하나 반환해야 하고, 
 그래서 `SELECT 함수명(...)`처럼 SQL 문장 안에서 바로 사용할 수 있어요.
 반면 프로시저는 값을 반환하지 않아도 되고 (또는 OUT 매개변수로 여러 값을 돌려줄 수 있고), 
 SQL 문장 안에서 바로 못 쓰고 `CALL 프로시저명()`으로 따로 호출해야 해요.

**문제 5.
이름을 입력받아 "안녕하세요, [이름]님!"을 출력하는 프로시저 `인사하기`를 작성하시오.

delimiter $$
drop procedure if exists 인사하기 $$

create procedure 인사하기 (in 이름 varchar(20))
begin
 select concat('안녕하세요', 이름, '님!');
end $$
delimiter ;

call 인사하기('철수');

**문제 6. --procedure가 아닌 function
가격을 입력받아 10% 세금을 계산해서 반환하는 함수 `세금계산`을 작성하시오. (정수 반환)

--procedure - in/out 붙임
delimiter $$
drop procedure if exists 세금계산 

create procedure 세금계산(in 가격 int) returns int
deterministic
begin
 return 가격 * 0.1;
end $$
delimiter ;

--function 함수는 무조건 "값을 받아서 → 계산해서 → RETURN으로 딱 하나 돌려주는" 딱 정해진 구조예요. 
--그래서 매개변수는 항상 "들어오는 값"일 수밖에 없으니

delimiter $$
drop procedure if exists 세금계산 

create procedure 세금계산(가격 int) returns int
deterministic
begin
 return 가격 * 0.1;
end $$
delimiter ;
select 세금계산(1000);

**문제 7.
`회원` 테이블에 새 행이 INSERT되면, 자동으로 `로그` 테이블에 "가입: [아이디]" 메시지를 넣는 트리거를 작성하시오. (로그 테이블 컬럼: MSG)
delimiter $$
drop trigger if exists TRI1;

create trigger TRI1
after insert on 회원
for each row
begin
 insert into 로그(MSG) values(concat('가입: ', new.ID));
end $$
delimiter ;

**문제 8.
1부터 5까지 더한 값을 구하는 WHILE 반복문을 작성하시오. (변수: i, sum)

declare i int default 1;
declare sum int default 0;
while i <= 5 do
 set sum = sum + i;
 set i + i+1;
end while;

`WHILE 조건 DO ~ END WHILE;`

**문제 9.
UPDATE 트리거에서 "수정되기 전 값"과 "수정된 후 값"을 각각 무엇으로 참조하는가?
`OLD.PWD`, `NEW.PWD`
 INSERT 트리거는 `NEW`만 있어요(새로 생긴 값만 있으니까). 
 DELETE 트리거는 `OLD`만 있어요(지워지기 전 값만 있으니까). 
 UPDATE 트리거만 `OLD`와 `NEW`를 둘 다 가질 수 있어요.

**문제 10.
커서(CURSOR)를 사용하는 이유를 한 문장으로 설명하시오.
SELECT의 조회 결과가 여러 행일 때, 그 결과를 한 줄(행)씩 순서대로 꺼내서 하나하나 처리하고 싶을 때 사용해요.
일반 SQL은 "표 전체"를 한 번에 다루는 게 기본이지만, 프로그래밍처럼 "한 줄씩 반복 처리"가 필요할 때 
커서를 `DECLARE ... CURSOR FOR SELECT ...`로 선언하고 `OPEN → FETCH(반복) → CLOSE` 순서로 사용해요.