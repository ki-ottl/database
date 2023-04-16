-- QUIZ

-- 1. [KOPO_CHANNEL_RESULT] 테이블 내 관리법인(AP2ID)는 몇개가 있나요?

SELECT DISTINCT AP2ID
FROM KOPO_CHANNEL_RESULT;

-- 2. [KOPO_CHANNEL_RESULT] 지역정보(AP1NAME)가 "WEST"이면서 
-- 연주차정보(YEARWEEK)가 "201720" 이상인 데이터에서 
-- 거래한 거래처는 총 몇 개 인가요? (거래처 개수만 작성 예:5)

-- 17개
SELECT DISTINCT  ACCOUNTNAME
FROM KOPO_CHANNEL_RESULT
WHERE 1=1
AND AP1NAME = 'WEST'
AND YEARWEEK >= 201720;

-- 3. KOPOPRODUCT_VOLUME_QUIZ 테이블에는 "A01" 지역 데이터만 315건의 데이터가 있습니다. 
-- 여기서 지역정보(REGIONID)만 "A02"로 나머지 컬럼값은 동일한 데이터를 추가하여 30건의 데이터가 존재하는 테이블을 생성하시오. 
-- 테이블명 "KOPO_PRODUCT_QUIZ_23홍길동" (단, 절대 기존 테이블은 건드리지 않습니다.) 
-- *작성한 쿼리를 하단에 입력* 만약 건드릴 위험이 있다면 KOPOPRODUCT_VOLUME홍길동 테이블 만들어서 작성

-- 315건의 데이터 확인
SELECT *
FROM KOPO_PRODUCT_VOLUME_QUIZ;

-- REGIONID가 'A02'인 애들을 가지고 온다
SELECT 'A02' AS REGIONID,
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME
FROM KOPO_PRODUCT_VOLUME_QUIZ;

-- 최종적으로 UNION으로 합친 것을 조회
SELECT *
FROM KOPO_PRODUCT_VOLUME_QUIZ
UNION
SELECT 'A02' AS REGIONID,
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME
FROM KOPO_PRODUCT_VOLUME_QUIZ;

-- case1) 조회한 내용을 테이블로 만들기
INSERT INTO KOPO_PRODUCT_VOLUME_한지원2
SELECT *
FROM KOPO_PRODUCT_VOLUME_QUIZ
UNION
SELECT 'A02' AS REGIONID,
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME
FROM KOPO_PRODUCT_VOLUME_QUIZ;

-- case2) 조회한 내용을 테이블로 만들기 
CREATE TABLE KOPO_PRODUCT_VOLUME_한지원3 AS
SELECT *
FROM KOPO_PRODUCT_VOLUME_QUIZ
UNION
SELECT 'A02' AS REGIONID,
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME
FROM KOPO_PRODUCT_VOLUME_QUIZ;
-- cf) UNION은 컬럼의 갯수가 같아야 한다.

-- 4. 아래 테이블에서 도시개발사가 하울팀 카울팀인 것을 추출

-- 정답
SELECT *
FROM HK1
WHERE 도시개발사 LIKE '%울%';

-- 오답 : IN을 사용하려면 정확하게 부합해야 한다.
SELECT *
FROM HK1
WHERE 도시개발사 IN('하울', '카울') 

SELECT *
FROM HK1
WHERE 도시개발사 IN('하울팀', '카울팀') 







