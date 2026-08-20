drop table if exists TR_LOGIN;
drop table if exists TR_MYHOME;
drop table if exists TR_MEMBER;

create table TR_MEMBER ( -- 회원
    ID varchar(10) primary key,
    PWD varchar(10) not null,
    NAME varchar(20) not null,
    EMAIL varchar(20) unique,
    RDATE date
);
create table TR_LOGIN ( -- 로그인
    ID varchar(10),
    PWD varchar(10),
    primary key (ID),
    foreign key (ID) references TR_MEMBER(ID) on delete cascade
);
create table TR_MYHOME ( -- 홈페이지
    SEQ int primary key auto_increment,
    ID varchar(10) not null,
    HNAME varchar(20) not null,
    TOTCOUNT int default 0,
    HMSG varchar(15),
    CDATE date,
    foreign key (ID) references TR_MEMBER(ID) on delete cascade
);

show tables;


--Q1) trigger1:회원가입을 하면 
     -- '로그인 테이블'에 ID/PWD입력, 
     -- '홈페이지 테이블'에 시퀀스와 ID/HNAME에 입력되는 트리거 
	delimiter $$
	drop trigger if exists TR1;

	create trigger TR1
	after insert on TR_MEMBER
	for each row
	begin
	 insert into TR_LOGIN(ID, PWD)
	 values(new.ID, new.PWD);

	 insert into TR_MYHOME(ID, HNAME)
	 values (new. ID, new.NAME);

	end $$

	delimiter ;

	--확인
	insert into TR_MEMBER values (
	'hong', '1234', '홍길동', 'hong@daum.net', curdate());
	select * from TR_MEMBER;
	select * from TR_LOGIN;
	select * form TR_MYHOME;


--Q2) trigger2:회원비번수정시.. 로긴 테이블의 PWD도 수정되는 트리거 

	delimiter $$
	drop trigger if exists TR2;

	create trigger TR2
	after update on TR_MEMBER
	for each row
	begin
	 if new.PWD != old.PWD then
	  update TR_LOGIN
	  set PWD = new.PWD
	  where ID = new.ID;
	 end if;

	end $$

	delimiter ;

	--확인
	update TR_MEMBER set PWD = '4321' where ID='hong';
	select * from TR_MEMBER;
	select * from TR_LOGIN;
