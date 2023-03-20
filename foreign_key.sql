-- 외래키 (Foreign Key)
-- : 다른 릴레이션(테이블)의 기본키를 참조하는 속성 (다른 테이블의 기본키를 땡겨오는 것)

-- 외래키는 테이블이 두 개 있을 때 해당된다.
-- 외래키의 정의는 다른 테이블의 기본키를 땡겨오는 것.
-- 만약 타 테이블의 기본키를 당겨오지 않는다면, 중복된 값을 보고 혼선이 생길 수 있다.
-- ex) 행사번호가 EV01인데 하나는 행사를 30%한다고 하고, 하나는 50% 한다고 하면..?

-- 외래키 생성 방법
CREATE TABLE KOPO_PRODUCT_VOLUME(
컬럼명1 타입(길이),
…
constraints [fk명] foreign key (컬럼명) references 기본키포함테이블명(해당테이블 기본키) )

-- constraints : 제약조건을 주겠다
-- references : 참조하겠다.

 CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
     REGIONID VARCHAR2(20),
     PRODUCTGROUP VARCHAR2(20),
     YEARWEEK VARCHAR2(8),
     VOLUME NUMBER NOT NULL,
     EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references KOPO_EVENT_INFO_FOREIGN(EVENTID) );
 
--constraints : 제약조건을 주겠다
--fk_kopo_product_volume_foreign : FK 이름
--eventid : 외래키로 설정할 컬럼명
--references : 참조하겠다
--KOPO_EVENT_INFO_FOREIGN(EVENTID) : KOPO_EVENT_INFO_FOREIGN 테이블의 EVENTID를

