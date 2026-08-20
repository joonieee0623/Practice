table 복사 : DDL

DML
1. 테이블내의 데이터를 '입력', '수정', '삭제'하는 SQL문
2. 종류
 1) insert
	insert into dept2 values(컬럼 순서대로);
	insert into dept2 values(50, '개발부', '서울');
	select * from dept2; --확인
	insert into emp2 values(9001, '강감찬', '개발', 7902, now(), 4000, null, 60); --error
	insert into emp2 values(9001, '강감찬', '개발', 7902, now(), 4000, null, 50);
	insert into emp2 values(9001, '강감찬', null, 7902, now(), null, null, null); --필수 empno 무조건 넣어야 함/이건 너무 길어
	insert into emp2(empno, ename, hiredate) values(9002, '이순신', now());  -- 넣고 싶은 것만 pri인 9001(존재하는)로 넣으면 error
	insert into emp2(empno, ename, hiredate) values(9001, '세종대왕', now()); --error
	insert into emp2(ename, hiredate) values('이순신', now()); --error
	select * from emp2 where empno>9000; --확인

 2) update
	update emp2 set ename='김감찬', sal=6000; --errpr emp2에 있는 모든 게 바뀌어버림 반드시 where이 있어야 함
	update emp2 set ename='김감찬', sal=6000 where empno=9001;
	--9001을 9003으로 바꿀?
	update emp2 set empno=9003 where empno=9001; --pk컬럼도 수정가능
	update emp2 set deptno=10 where empno=9003; --fk컬럼도 수정가능 emp2(자식table은 맘대로 바꿀수 있다)
	--부모table은 못 바꾸는데, 자식table을 삭제하면 가능/강제로 부모-자식 같이 바꿈(cascade옵션)
	--참조하는 사람(40번 부서 사람없음)이 없으면 수정 가능
	--부모가 바꾸는 것 
	
 3) delete
	delete from emp2; --다 삭제됨.. where조건 꼭!
	delete from emp2 where empno=9002; --9002를 삭제
	delete from emp2 where deptno=10;  --10번 부서인 사원 모두 삭제
	delete from dept2 where deptno=20; --부모table삭제X because.. 자식table이 있으니/
	--테이블 생성시 on delete cascade 옵션을 줌(부모 죽으면 자식의 자식의 자식도 죽음->연쇄적으로 data 날아감)->data의 무결성:논리적으로 타당


