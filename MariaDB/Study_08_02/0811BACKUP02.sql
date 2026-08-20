-- 부서
CREATE TABLE `DEPT` (
	`DEPTNO` INT(2),     
	`DNAME`  VARCHAR(14),
	`LOC`    VARCHAR(14),
)


-- 부서
ALTER TABLE DEPT PRIMARY KEY (DEPTNO);

-- 사원
CREATE TABLE `EMP` (
	`EMPNO`    INT(4)       NOT NULL COMMENT '사원번호', -- 사원번호
	`ENAME`    VARCHAR(10)  NULL     COMMENT '사원이름', -- 사원이름
	`JOB`      VARCHAR(9)   NULL     COMMENT '직업', -- 직업
	`MGR`      INT(4)       NULL     COMMENT '사수', -- 사수
	`HIREDATE` DATE         NULL     COMMENT '입사일', -- 입사일
	`SAL`      DECIMAL(7,2) NULL     COMMENT '급여', -- 급여
	`COMM`     DECIMAL(7,2) NULL     COMMENT '커미션', -- 커미션
	`DEPTNO`   INT(2)       NULL     COMMENT '부서번호' -- 부서번호
)
COMMENT '사원';

-- 사원
ALTER TABLE `EMP`
	ADD CONSTRAINT `PK_EMP` -- 사원 기본키
		PRIMARY KEY (
			`EMPNO` -- 사원번호
		);

-- 사원
ALTER TABLE `EMP`
	ADD CONSTRAINT `FK_DEPT_TO_EMP` -- 부서 -> 사원
		FOREIGN KEY (
			`DEPTNO` -- 부서번호
		)
		REFERENCES `DEPT` ( -- 부서
			`DEPTNO` -- 부서번호
		);