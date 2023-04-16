-- 테이블(릴레이션)
-- 행과 컬럼(열)이 있는 데이터
-- RDB(Relational DataBase)라고도 부른다

-- 사전 작업
MYDB2 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  ) 
  
-- 사용자 생성
--CREATE USER 사용자명
--IDENTIFIED BY 비밀번호
CREATE USER KIOTTL
IDENTIFIED BY KIOTTL;

-- 사용자한테 권한을 준다  
-- CONNECT(접속), RESOURCE(자원), DBA(전체권한)
GRANT CONNECT, RESOURCE, DBA TO KIOTTL;

-- 이렇게 하고 저 공간에서 SELECT * FROM TABS; 하면 나오는 것은
-- 오라클 운영을 위한 것이므로 수정해선 안됨!
-- 따라서 자신만의 공간이 필요하다!
-- MYDB2로 ID랑 PW를 기입해서 접속하자!

-- 생성한 사용자 정보 확인
SELECT *
FROM DBA_USERS

-- 사용자 비밀번호 변경
ALTER USER {사용자명}
IDENTIFIED BY {비밀번호}

-- 사용자 삭제
DROP USER {사용자명} CASCADE;

--데이터베이스 공유 개념
--타인 데이터베이스를 가져올 때
--1. 접속정보 등록, 2. 방화벽 해제, 3. 접근제한 해제를 해야한다!
--접속정보 등록은 TNSnamesEditor
--방화벽 해제는 아래와 같이하고,
--접근제한 해제는 Toad의 SQL NET Editor

--타인의 Database에 접속해보기
--IP, PORT, DATABASE NAME, USER NAME, PASSWORD
--받아서 똑같이 TNSnamesEditor에서 접속정보 등록을 해준다.
--접근제한 해제, 방화벽 해제를 선행해야 하기 때문에 안될 것이다.

--방화벽 해제
--고급 보안이 포함된 Windows Defender 방화벽
---> 인바운드 규칙 (들어오는 규칙을 수정하겠다)
---> 새 규칙
---> 포트
---> 특정 로컬포트에 1521 기재 (1521로 접근하는 것을 열어주겠다<-는 느낌)
---(cf. 1521, 3306, 5432가 실무에서 가장 많이 사용되는 삼총사)
---> (다음) 이름 : 데이터베이스 접속 포트 / 설명 : 오라클 1521








  