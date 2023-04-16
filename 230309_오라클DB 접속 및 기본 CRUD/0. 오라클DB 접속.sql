-- 데이터베이스 생성 및 구성

-- DBMS 설치

-- Oracle 설치 (서버)
-- SQL은 일반화가 되어있어서 가장 많이 사용되는 Oracle로 배우는 것이 유리하다.
-- 종류 : Oracle / Postgresql / MariaDB(MySQL의 오픈소스 버전) / MongoDB 등

-- Oracle 설치
-- 1. 제어판에서 기설치된 파일 있는지 확인 (Oracle Database~)
-- 2. 오라클 설치 (종류 - 서버, 클라이언트가 있다.)
-- 서버) 돋보기 > 시스템 정보 > 시스템 종류 (64 기반)
-- Oracle 서버 / 큰 데이터베이스 저장소라고 생각

-- 명령 프롬프트 > sqlplus >
-- Enter user-name : system
-- Enter password : oracle 

-- cmd에 sqlplus 검색하면 나오는 이유는 path에 자동 등록되어있기 때문.
-- (고급 시스템 설정 보기 > 환경 변수 > 시스템 변수 > Path > 편집 )
-- 안 나오는 경우에는 환경 변수에 실행파일이 있는 위치를 등록.
-- (환경변수 내 path로 특정 폴더 경로를 지정하면 해당 폴더 내 실행 파일은 어디서든 실행 가능하다.)

-- Toad 설치 (클라이언트)
-- 클라이언트 : 데이터베이스 조회 툴
-- Toad for Oracle : SQL이라는 언어를 편집하는 편집 유료 tool

-- DB 접속 시 필요한 정보
-- DB타입(본인PC데이터베이스), DB종류(ORACLE), 구분(개발서버), 아이피(내 PC(무선or유선네트워크)), 포트(1521), 아이디(system), 비번(oracle), DB명(xe)

-- cf) cmd > ipconfig : 네트워크에 대한 정보 확인 가능
-- 유선의 경우 "이더넷 어댑터 이더넷 : IPv4 주소
-- 무선의 경우 "무선 LAN 어탭터 Wi-Fi : 기본 게이트웨이"
-- 포트 : 서비스들이 차지하는 공간 (ex. 아파트 호수 느낌)

-- DB 접속
-- 1. [sessions > new connection] > 우측 하단 TNSNames Editor 클릭 (tnsnames.ora (오라클의 접속정보를 관리/편집하는 파일))
-- 2. 아래에 있는 내용 복사해서 상단에 붙여 넣고 수정 작업 (이름은 공백 없이 기재)
 MYDB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.110.20)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE) --  이름은 공백 없이 기재
    )
  )
-- 3. Database에서 MYDB 확인 가능

-- User/Schema : system
-- Password : oracle
-- Database : MYDB
-- 기입 후 Connect 클릭하면 접속 완료!

-- 전체 테이블 조회 쿼리
SELECT *
FROM TABS

-- 기입 후 control + enter 하면 실행
