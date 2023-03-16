CREATE TABLE STUDENTLIST (
    STUDENT_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    MAJOR VARCHAR(100) NOT NULL
);

CREATE TABLE GRADELIST (
    NUM NUMBER NOT NULL PRIMARY KEY,
    STUDENT_ID VARCHAR(100) NOT NULL,
    SUBJECT_NAME VARCHAR(100) NOT NULL,
    SCORE NUMBER NOT NULL,
    FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTLIST(STUDENT_ID)
);

INSERT INTO STUDENTLIST
VALUES ('11111111', '한지원1', '국어국문학과');

INSERT INTO STUDENTLIST
VALUES ('11111122', '한지원2', '영어영문학과');

INSERT INTO STUDENTLIST
VALUES ('11111133', '한지원3', '독어독문학과');

SELECT * 
FROM STUDENTLIST;

INSERT INTO GRADELIST 
VALUES (1,'11111111', '소설', 88);

INSERT INTO GRADELIST 
VALUES (2,'11111133', '독일어', 95);

INSERT INTO GRADELIST 
VALUES (3,'11111111', '시', 79);

INSERT INTO GRADELIST 
VALUES (4,'11111122', '영어', 92);

SELECT *
FROM GRADELIST;

-- 에러 발생시키기
-- 1. 도메인 무결성 제약조건 : 속성값 위배
-- NUMBER로 지정한 곳에 문자 넣으면 안된다.
-- ORA-00001: unique constraint (KIOTTL.SYS_C007045) violated
INSERT INTO GRADELIST 
VALUES (1,'11111111', '문학', 100);

-- 에러 발생시키기
-- 1. 도메인 무결성 제약조건 : 속성값 위배
-- NOT NULL로 지정한 곳에 NULL 넣으면 안된다.
-- ORA-01400: cannot insert NULL into ("KIOTTL"."GRADELIST"."NUM")
INSERT INTO GRADELIST 
VALUES (NULL,NULL, NULL, NULL);

-- 에러 발생시키기
-- 2. 개체 무결성 제약조건 : 기본키 위배
-- 테이블은 무조건 PK를 가져야 하고, PK는 UNIQUE&NULL이다.
-- 기본키에 중복값 넣으려는 시도
-- ORA-00001: unique constraint (KIOTTL.SYS_C007045) violated
INSERT INTO GRADELIST
VALUES (1,'11111111', '문학', 100);

-- 에러 발생시키기
-- 2. 개체 무결성 제약조건 : 기본키 위배
-- 테이블은 무조건 PK를 가져야 하고, PK는 UNIQUE&NULL이다.
-- 기본키에 NULL 값 넣으려는 시도
-- ORA-01400: cannot insert NULL into ("KIOTTL"."GRADELIST"."NUM")
INSERT INTO GRADELIST
VALUES (NULL,'11111111', '문학', 100);


-- 에러 발생시키기
-- 3. 참조 무결성 제약조건 : 외래키 위배
-- 부모 테이블에 없는 학번으로 성적 입력 시도
-- STUDENT_ID가 외래키로 설정되어 있기 때문에 
-- STUDENT_LIST 테이블에 없는 학번에 대해서는 입력이 안 된다
-- ORA-02291: integrity constraint (KIOTTL.SYS_C007046) violated - parent key not found
INSERT INTO GRADELIST
VALUES (5, '11111177', '건축학개론', 85);

-- 에러 발생시키기
-- 3. 참조 무결성 제약조건 : 외래키 위배
-- NULL값인 것은 허용. 참조 불가능한 경우에는 비허용 
-- 자식이 부모를 참조하는 경우, 부모의 기본키는 자식에서 외래키로 사용된다.
-- 자식 테이블에 사용하고 있는 데이터가 있어서 부모 테이블의 데이터를 삭제 불가
-- ORA-02292: integrity constraint (KIOTTL.SYS_C007036) violated - child record found
DELETE 
FROM STUDENTLIST
WHERE STUDENT_ID = '11111111';

SELECT * 
FROM STUDENTLIST;

SELECT *
FROM GRADELIST;

--규칙
--자식(테이블)은 부모(테이블) 없이 만들어 질수없다.
--자식(테이블)을 drop, delete 하지않고 부모(테이블)을 삭제 할 수 없다.
--부모(테이블)에 데이터가 없으면 자식(테이블)에 데이터를 넣을수 없다.