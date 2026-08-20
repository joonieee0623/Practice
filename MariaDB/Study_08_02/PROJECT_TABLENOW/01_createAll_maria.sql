--mysql -u team2 -p
--Enter password: java

--show databases;
--use tablenow_schema
--show tables;


drop table if exists FAV;
drop table if exists WAIT;
drop table if exists MENU;
drop table if exists R_HOURS;
drop table if exists RESTAURANT;
drop table if exists MN_CATEGORY;
drop table if exists LOC;
drop table if exists MEMBER;

create table MEMBER (
    M_ID varchar(50) not null,
    M_NAME varchar(50) not null,
    M_EMAIL varchar(100),
    M_PHONE varchar(20) not null,
    M_JOIN date default curdate(),
    primary key(M_ID)
);

create table LOC (
    L_CODE int not null,
    L_NAME varchar(20) not null,
    primary key(L_CODE)
);

create table RESTAURANT (
    R_CODE int not null,
    L_CODE int not null,
    R_NAME varchar(50) not null,
    R_ADDR varchar(200) not null,
    primary key(R_CODE),
    constraint RESTAURANT_FK foreign key(L_CODE) references LOC(L_CODE)
);

create table FAV (
    R_CODE int not null,
    M_ID varchar(50) not null,
    F_REG date default curdate(),
    primary key(R_CODE, M_ID),
    constraint FAV_RESTAURANT_FK foreign key(R_CODE) references RESTAURANT(R_CODE),
    constraint FAV_MEMBER_FK foreign key(M_ID) references MEMBER(M_ID)
);

create table WAIT (
    R_CODE int not null,
    W_NO int not null,
    W_DATE date default curdate(),
    M_ID varchar(50) not null,
    W_COUNT int not null,
    W_STATUS varchar(10) not null,
    W_DELAY int,
    primary key(R_CODE, W_NO, W_DATE),
    constraint WAIT_FK foreign key(M_ID) references MEMBER(M_ID)
);

create table R_HOURS (
    R_CODE int not null,
    H_DAY char(1) not null,
    H_OPEN time,
    H_CLOSE time,
    B_START time,
    B_END time,
    W_END time,
    primary key(R_CODE, H_DAY),
    constraint RHOURS_FK foreign key(R_CODE) references RESTAURANT(R_CODE)
);

create table MN_CATEGORY (
    C_NO int not null,
    C_NAME varchar(20) not null,
    primary key(C_NO)
);

create table MENU (
    R_CODE int not null,                  
    MN_NO int not null, 
    C_NO int not null, 
    MN_NAME varchar(50) not null,
    MN_PRICE int,
    primary key(R_CODE, MN_NO),
    constraint MENU_RCODE_FK foreign key(R_CODE) references RESTAURANT(R_CODE),
    constraint MENU_CATEGORY_FK foreign key(C_NO) references MN_CATEGORY(C_NO)
);