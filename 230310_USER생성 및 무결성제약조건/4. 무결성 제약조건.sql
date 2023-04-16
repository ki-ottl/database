-- 무결성 제약조건
-- : 이런 세 가지 제약조건이 있기 때문에 데이터베이스를 신뢰할 수 있다.

-- 1. 도메인 무결성 제약조건(속성값 위배) : 지정된 컬럼 속성 값 외에 허용하지 않는다.
-- 2. 개체 무결성 제약조건(기본키 위배) : 릴레이션은 기본키를 지정(NOT NULL,ONLY ONE)
-- 3. 참조 무결성 제약조건(외래키/참조키 위배)

-- 1. 도메인 무결성 제약조건 : 속성값 위배
-- 지정된 컬럼 속성 값 외에 허용하지 않는다.
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

-- 2. 개체 무결성 제약조건 : 기본키 위배
-- 릴레이션은 기본키를 지정(NOT NULL,ONLY ONE)
-- 릴레이션은 무조건 PK를 가져야 하고 PK는 UNIQUE & NOT NULL이다.
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



