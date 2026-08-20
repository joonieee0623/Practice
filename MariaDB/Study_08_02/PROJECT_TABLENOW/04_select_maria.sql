-- 1. 영업 시작 시간이 오전 11시인 매장명을 나열하시오.
select R_NAME, H_OPEN from RESTAURANT
natural join R_HOURS
where H_OPEN = '11:00:00'
group by R_NAME;

-- 2. 영업 종료 시간이 오후 10시인 매장명과 지역명을 나열하시오.
select R_NAME, L_NAME, H_CLOSE from RESTAURANT
natural join LOC
natural join R_HOURS
where H_CLOSE='22:00:00'
group by R_NAME;

-- 3. '한식' 카테고리에 해당하는 메뉴를 판매하는 매장명과 메뉴명을 나열하시오.
select R_NAME, MN_NAME, C_NAME from RESTAURANT
natural join MENU
natural join MN_CATEGORY
where C_NAME='한식';

-- 4. 메뉴 가격이 10,000원 이상인 메뉴의 매장명, 메뉴명, 가격을 나열하시오.
select R_NAME, MN_NAME, MN_PRICE from RESTAURANT
natural join MENU
where MN_PRICE>=10000;

-- 5. '서울 홍대' 지역에 위치한 매장명과 주소를 나열하시오.
select R_NAME, R_ADDR, L_NAME from RESTAURANT
natural join LOC
where L_NAME='서울 홍대';

-- 6. 찜을 한 회원의 이름과 찜한 매장명을 나열하시오.
select M.M_NAME, R.R_NAME from MEMBER M
natural join FAV F
natural join RESTAURANT R;

-- 7. 2026년 8월에 찜한 회원의 이름과 매장명을 나열하시오.
select M.M_NAME, R.R_NAME, F.F_REG
from FAV F
natural join MEMBER M
natural join RESTAURANT R
where F.F_REG between '2026-08-01' and '2026-08-31'
order by F.F_REG;

-- 8. 현재 대기 상태인 회원의 이름과 매장명, 대기 인원수를 나열하시오.
select M.M_NAME, R.R_NAME, W.W_COUNT
from WAIT W
natural join MEMBER M
natural join RESTAURANT R
where W.W_STATUS = '대기'
  and W.W_DATE = curdate()
order by W.W_NO;

-- 9. 대기 인원이 3명 이상인 매장명과 회원명을 나열하시오.
select R.R_NAME, M.M_NAME, W.W_COUNT
from WAIT W
natural join MEMBER M
natural join RESTAURANT R
where W.W_COUNT >= 3
order by W.W_COUNT desc;

-- 10.대기 상태가 '노쇼'인 회원의 이름과 매장명을 나열하시오.
select M.M_NAME, R.R_NAME
from WAIT W
join MEMBER M on W.M_ID = M.M_ID
join RESTAURANT R on W.R_CODE = R.R_CODE
where W.W_STATUS = '노쇼';

-- 11.브레이크타임이 있는 매장의 이름과 브레이크타임 시작 및 종료 시간을 나열하시오.
select distinct R.R_NAME, H.B_START, H.B_END
from R_HOURS H
join RESTAURANT R on H.R_CODE = R.R_CODE
where H.B_START is not null
order by R.R_NAME;

-- 12. 웨이팅 마감 시간이 오후 8시인 매장의 이름과 지역명을 나열하시오.
select R_NAME, L_NAME, W_END from RESTAURANT
natural join LOC
natural join R_HOURS
where W_END='20:00:00'
group by R_NAME;

-- 13.가격이 10,000원 이하인 메뉴를 판매하는 매장의 이름과 메뉴명을 나열하시오.
select R.R_NAME, MN.MN_NAME, MN.MN_PRICE
from MENU MN
join RESTAURANT R on MN.R_CODE = R.R_CODE
where MN.MN_PRICE <= 10000
order by R.R_NAME, MN.MN_PRICE;

-- 14.'양식' 카테고리에 속하는 메뉴 중 가격이 20,000원 이하인 메뉴의 매장명, 메뉴명, 가격을 나열하시오.
select R.R_NAME, MN.MN_NAME, MN.MN_PRICE
from MENU MN
join RESTAURANT R on MN.R_CODE = R.R_CODE
join MN_CATEGORY C on MN.C_NO = C.C_NO
where C.C_NAME = '양식'
  and MN.MN_PRICE <= 20000
order by MN.MN_PRICE;

-- 15. 오늘 대기 팀이 2팀 이상인 매장의 이름과 대기 팀 수를 나열하시오.
select R.R_NAME, count(*) as 대기팀수
from WAIT W
join RESTAURANT R on W.R_CODE = R.R_CODE
where W.W_DATE = curdate()
  and W.W_STATUS = '대기'
group by R.R_CODE, R.R_NAME
having count(*) >= 2;