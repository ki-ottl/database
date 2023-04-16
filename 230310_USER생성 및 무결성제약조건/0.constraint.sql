-- 무결성 제약조건
-- : 이런 세 가지 제약조건이 있기 때문에 데이터베이스를 신뢰할 수 있다.
-- 도메인 무결성 제약조건(속성값 위배) : 지정된 컬럼 속성 값 외에 허용하지 않는다.
-- 개체 무결성 제약조건(기본키 위배) : 릴레이션은 기본키를 지정(NOT NULL,ONLY ONE)
-- 참조 무결성 제약조건(외래키/참조키 위배)

-- 1. 도메인 무결성 제약조건 : 속성값 위배
-- : 지정된 컬럼 속성 값 외에 허용하지 않는다.
-- NUMBER 넣기로 했으면 N문자 집어넣기

CREATE TABLE PRACTICE_TABLE_2 (
NAME VARCHAR2(100), 
BIRTH VARCHAR2(100), 
ADDRESS VARCHAR2(100) NOT NULL,
HP NUMBER;
)

-- ORA-01722: invalid number
-- NUMBER에다가 문자 집어넣어서 생긴 오류
INSERT INTO PRACTICE_TABLE_2
VALUES('한지원', '950126' , 'SEOUL' ,'문자입니다');

-- 오라클의 문자는 숫자도 껴안기 때문에 숫자를 넣어도 된다.
-- 문자임에도 숫자로 인식해서 넣어준다.
INSERT INTO PRACTICE_TABLE_2
VALUES('한지원', 950126 , 'SEOUL', 01011111111);

-- ORA-01400: cannot insert NULL into ("KIOTTL"."PRACTICE_TABLE_2"."ADDRESS")
-- NOT NULL 컬럼에다가 NULL값 집어넣었기 때문에 오류
INSERT INTO PRACTICE_TABLE_2
VALUES('한지원2','950126', NULL, 01011111111);

--2. 개체 무결성 제약조건 : 기본키 위배
-- : 릴레이션은 기본키를 지정(NOT NULL,ONLY ONE)
-- : 릴레이션은 무조건 PK를 가져야 하고 PK는 UNIQUE & NOT NULL이다.
-- 기본키에 중복값을 넣은 경우에 에러
-- 기본키에 NULL값을 집어넣으면 에러

-- ORA-00001: unique constraint (KIOTTL.PK_PRACTICE_TABLE_2) violated 
-- 기본키에 중복값 넣음
INSERT INTO PRACTICE_TABLE_2
VALUES('한지원', 950126 , 'SEOUL', 01011111111);

-- ORA-01400: cannot insert NULL into ("KIOTTL"."PRACTICE_TABLE_2"."ADDRESS")
-- 기본키에 NULL값을 집어넣으면 에러
INSERT INTO PRACTICE_TABLE_2
VALUES('한지원2','950126', NULL, 01011111111);

-- 3. 참조 무결성 제약조건(외래키 위배)

-- 부모테이블 생성
 CREATE TABLE KOPO_EVENT_INFO_FOREIGN(
     EVENTID VARCHAR2(20),
     EVENTPERIOD VARCHAR2(20),
     PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(EVENTID));

-- 자식테이블 생성
 CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
     REGIONID VARCHAR2(20),
     PRODUCTGROUP VARCHAR2(20),
     YEARWEEK VARCHAR2(8),
     VOLUME NUMBER NOT NULL,
     EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references KOPO_EVENT_INFO_FOREIGN(EVENTID) );
 
-- INSERT 생략
 
-- ORA-02291: integrity constraint (KIOTTL.SYS_C007046) violated - parent key not found
-- 부모 테이블에 없는 학번으로 성적 입력 시도
-- EVENTID가 외래키로 설정되어 있기 때문에 
-- KOPO_EVENT_INFO_FOREIGN 테이블에 값이 없는 EVENTID에 대해서는 입력이 안 된다
-- ORA-02291: integrity constraint (KIOTTL.SYS_C007046) violated - parent key not found
INSERT INTO KOPO_PRODUCT_VOLUME_FOREIGN
VALUES ('A01','SEOUL','202301', 100, 'EVENT10');

-- ORA-02292: integrity constraint (KIOTTL.SYS_C007036) violated - child record found
-- 자식 테이블에 사용하고 있는 데이터가 있어서 부모 테이블의 데이터를 삭제 불가
DELETE 
FROM KOPO_EVENT_INFO_FOREIGN
WHERE EVENTID = 'EVENT01';

-- 나의 테이블을 만들어보기

CREATE TABLE STUDENTLIST (
    STUDENT_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    MAJOR VARCHAR(100) NOT NULL
    constraints PK_STUDENTLIST primary key (STUDENT_ID)
);

CREATE TABLE GRADELIST (
    NUM NUMBER NOT NULL PRIMARY KEY,
    STUDENT_ID VARCHAR(100) NOT NULL,
    SUBJECT_NAME VARCHAR(100) NOT NULL,
    SCORE NUMBER NOT NULL,
    constraint PK_GRADELIST FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTLIST(STUDENT_ID)
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

-- ON DELETE CASCADE : 부모 테이블에서 정보 삭제시 자식 테이블 해당 행 자체를 삭제함
-- ON DELETE SET NULL : 부모 테이블에서 정보 삭제시 자식 테이블 값 NULL 처리
