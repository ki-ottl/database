-- DB LINK 
-- 개발DB에 있는 형상을 운영DB로 이관하는 일!
-- DB LINK는 DB 가져오고 싶은 곳에서 생성!
-- DB LINK를 걸어두면 셀렉트 쿼리 하나로 타 PC의 데이터를 땡겨올 수 있다

-- 학교 서버의 테이블을 끌어와서 쓰기 
CREATE DATABASE LINK KOPOSERVER2
CONNECT TO kopo
IDENTIFIED BY kopo
Using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.110.112)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';

--DB LINK 확인
SELECT * 
FROM ALL_DB_LINKS;

-- 원격지의 DB 서버의 모든 테이블을 조회
SELECT *
FROM TABS@KOPOSERVER2;

-- 원격지의 DB 서버의 특정 테이블을 조회
SELECT *
FROM PRO_PROMOTION@KOPOSERVER2;

-- 원격지의 DB 서버에 있는 테이블을 내 공간에 생성
CREATE TABLE PRO_PROMOTION
AS
SELECT *
FROM PRO_PROMOTION@KOPOSERVER2;

-- 내 공간에 KOPOSERVER2의 PRO_PROMOTION 테이블 확인
SELECT *
FROM TABS;

-- DB LINK 제거
DROP TABLE PRO_PROMOTION






























