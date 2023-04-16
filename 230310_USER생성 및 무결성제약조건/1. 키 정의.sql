-- 키 정의

-- 기본키 (Primary Key) : 테이블 내에서 하나를 선정하여 대표로 삼는 키
-- 1. 식별할 수 있는 고유한 값을 가져야 한다.
-- 중복을 허락하지 않는다.
-- ex) 지점, 카드사, 주차가 기본키 설정이 되어있을 경우에
-- (서울지점, 하나카드, 202301, 100)
-- (서울지점, 하나카드, 202301, 200) -> 불가
-- 데이터의 신뢰성에 의문이 생기기 때문에
-- 1주차에 100개 판매인지 200 판매인지 혼선을 줄 수 있다.
-- 누군가에게 테이블을 받았을 때 가장 먼저 기본키가 무엇인지 파악해서
-- 지역, 상품, 주차별로 거래량을 수집했다는 것을 해석해야한다.

--- 기본 키 프라이머리 키 설정
CREATE TABLE KOPO_PRODUCT_VOLUME(
    REGIONID VARCHAR2(100),
    PRODUCT VARCHAR2(100),
    YEARWEEK VARCHAR2(100),
    QTY NUMBER,
    constraints PK_KOPO_PRODUCT_VOLUME primary key (REGIONID, PRODUCT,YEARWEEK);
)

-- constraints : 제약조건을 주겠다
-- PK_KOPO_PRODUCT_VOLUME : PK 이름 (나중에 PK명을 검색할 일이 생길 수 있음)
-- REGIONID, PRODUCT,YEARWEEK : 기본키로 설정할 컬럼

 CREATE TABLE KOPO_EVENT_INFO_FOREIGN(
     EVENTID VARCHAR2(20),
     EVENTPERIOD VARCHAR2(20),
     PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(EVENTID));

-- constraints : 제약조건을 주겠다
-- pk_kopo_event_info_foreign : PK 이름 (나중에 PK명을 검색할 일이 생길 수 있음)
-- EVENTID : 기본키로 설정할 컬럼
-- cf) PK : 기본키 명을 PK테이블명으로 설정하면 중복될 일이 없다(테이블명이 중복이 안되기 때문에)

INSERT INTO KOPO_PRODUCT_VOLUME
VALUES ('A01', 'PRODUCT01', '202301', 100);

-- 같은 데이터를 두 번 실행하면 에러가 뜬다.
-- ORA-00001: unique constraint(KIOTTL.PK_KOPO_PRODUCT_VOLUME)
-- 기본키가 위배되었다는 에러. (중복값을 허용하지 않기 때문)


-- 2. NULL 값은 허용하지 않는다.

INSERT INTO KOPO_PRODUCT_VOLUME
VALUES (NULL, 'PRODUCT01', '202301', 100);

-- 기본키에는 NULL이 들어갈 수 없다.
-- ORA-01400: cannot insert NULL into ("KIOTTL"."PK_KOPO_PRODUCT_VOLUME"."REGIONID")

-- cf) 기본키 조회 방법 (암기 불필요)
-- 기본키 조회 방법 ( P로 뜨는 것이 Primary key)
SELECT * FROM
ALL CONSTRAINTS
WHERE 1=1
AND TABLE_NAME = 'KOPO_PRODUCT_VOLUME'

-- 외래키 (Foreign Key)
-- : 다른 릴레이션(테이블)의 기본키를 참조하는 속성 (다른 테이블의 기본키를 땡겨오는 것)

-- 외래키는 테이블이 두 개 있을 때 해당된다.
-- 외래키의 정의는 다른 테이블의 기본키를 땡겨오는 것.
-- 만약 타 테이블의 기본키를 당겨오지 않는다면, 중복된 값을 보고 혼선이 생길 수 있다.
-- ex) 행사번호가 EV01인데 하나는 행사를 30%한다고 하고, 하나는 50% 한다고 하면..?

-- 외래키 생성 방법
-- CREATE TABLE KOPO_PRODUCT_VOLUME(
-- 컬럼명1 타입(길이),
-- …
-- constraints [fk명] foreign key (컬럼명) references 기본키포함테이블명(해당테이블 기본키) )
-- constraints : 제약조건을 주겠다
-- references : 참조하겠다

CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
     REGIONID VARCHAR2(20),
     PRODUCTGROUP VARCHAR2(20),
     YEARWEEK VARCHAR2(8),
     VOLUME NUMBER NOT NULL,
     EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references KOPO_EVENT_INFO_FOREIGN(EVENTID) );

-- constraints : 제약조건을 주겠다
-- fk_kopo_product_volume_foreign : FK 이름
-- eventid : 외래키로 설정할 컬럼명
-- references : 참조하겠다
-- KOPO_EVENT_INFO_FOREIGN(EVENTID) : KOPO_EVENT_INFO_FOREIGN 테이블의 EVENTID를


