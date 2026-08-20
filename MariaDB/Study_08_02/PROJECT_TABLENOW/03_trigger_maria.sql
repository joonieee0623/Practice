-- 트리거 삭제 및 생성
drop trigger if exists TRG_W_DELAY;

delimiter $$

create trigger TRG_W_DELAY
before update on WAIT
for each row
begin
 if new.W_DELAY > 3 and new.W_STATUS = '대기' then
   set new.W_STATUS = '취소';
 end if;

end $$

delimiter ;

-- 트리거 확인
show triggers;

-- 트리거 사용(update 예시)
select * from wait; --104번 대기 상태

update WAIT set W_DELAY=4 where R_CODE=305 and W_NO=104 and W_DATE=curdate();
select * from wait; --104번 취소됨

-- 초기화
update WAIT set W_DELAY=3, W_STATUS='대기' where R_CODE=305 and W_NO=104 and W_DATE=curdate();