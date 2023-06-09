-- ORDER BY : 정렬하기
-- ASC(오름차순), DESC(내림차순)
-- cf) QTY DESC가 많이 사용된다 

-- 어떤 데이터에 대해서 이해를 빨리 하기 위해서는 기본키를 먼저 찾아야 한다.
-- 기본키는 중복을 허용하지 않는 키이기 때문에,
-- 기본키로 정렬을 하면, 데이터를 하나하나 뜯어서 볼 수 있다.

-- 정렬안됨
 SELECT *
FROM KOPO_CHANNEL_RESULT
ORDER BY YEARWEEK;

-- 정렬됨 (오름차순)
SELECT AP2ID, SALESID, ITEM, YEARWEEK, QTY
FROM KOPO_CHANNEL_RESULT
ORDER BY AP2ID, SALESID, ITEM, YEARWEEK;

-- 정렬됨 (내림차순)
SELECT AP2ID, SALESID, ITEM, YEARWEEK, QTY
FROM KOPO_CHANNEL_RESULT
ORDER BY AP2ID, SALESID, ITEM, YEARWEEK DESC;

-- 실습 ) OPO_PRODUCT_VOLUME 테이블에서
-- 지역, 상품, 주차 오름차순 형태로 조회

-- 오름차순
SELECT *
FROM KOPO_PRODUCT_VOLUME
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK ASC;

-- 내림차순
SELECT *
FROM KOPO_PRODUCT_VOLUME
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK DESC;



-- LOWER 
-- 특정 값들을 소문자로 바꾸고 싶다
-- 컬럼의 이름은 그대로 있고, 속성값만 바뀐다.

 SELECT LOWER(PRODUCTGROUP)
 FROM KOPO_PRODUCT_VOLUME;
 
 SELECT LOWER(PRODUCTGROUP) AS PRODUCTNAME
 FROM KOPO_PRODUCT_VOLUME;
 
 SELECT *
 FROM LOGIN_TABLE
 WHERE ID = UPPER('haiteam');
 
-- MANAGER 조회
SELECT *
FROM LOGIN_TABLE 
WHERE ID = UPPER('manager');

-- manager 조회
SELECT *
FROM LOGIN_TABLE 
WHERE ID = LOWER('MANAGER');



-- CONCAT : 합침
-- cf) 오라클 외 타 데이터베이스에서도 사용이 가능한 문법인지 확인 필요!

SELECT A.*,
       CONCAT(REGIONID,PRODUCTGROUP) AS IDX,
       REGIONID||'_'||PRODUCTGROUP AS IDX2,
       -- 기본키를 합쳐버렸다. 중복값 확인 시, 편리함.
       CONCAT(REGIONID,CONCAT(PRODUCTGROUP,YEARWEEK)) AS KEY_VALUE
FROM KOPO_PRODUCT_VOLUME A;


-- SUBSTR : 추출
-- 현재에 있는 컬럼에서 특정 인덱스로 컬럼값을 추출할 수 있다.

SELECT SUBSTR(PRODUCTGROUP, 0, 3)
FROM KOPO_PRODUCT_VOLUME;

-- 실습 ) KOPO_PRODUCT_VOLUME 테이블에서 연도, 주차

SELECT SUBSTR(A.YEARWEEK, 1, 4) AS YEAR,
       SUBSTR(A.YEARWEEK, 5, 6) AS WEEK,
       A.*
FROM KOPO_PRODUCT_VOLUME A;

-- 시작포인트(5)부터 2개의 숫자를 가져올 것이라는 의미라서
-- 이렇게 쓸 수 있다
SELECT SUBSTR(A.YEARWEEK, 1, 4) AS YEAR,
       SUBSTR(A.YEARWEEK, 5, 2) AS WEEK,
       A.*
FROM KOPO_PRODUCT_VOLUME A;



-- LPAD, RPAD : 자리수

--LPAD
 SELECT A.*,
        LPAD ( UPPER(CUSTID), 10, '0') AS CSID 
 FROM CUSTOMERDATA A;
 
--RPAD
 SELECT A.*,
        RPAD ( UPPER(CUSTID), 10, '0') AS CSID 
 FROM CUSTOMERDATA A;

-- 실습 ) KOPO_CUSTOMERDATA 테이블에서
-- CUSTOMERCODE를 12자리로 조회하세요
-- 단, 12자리가 안될 경우 앞에 *로 채우세요.

 SELECT LPAD( CUSTOMERCODE, 12, '*') AS CSCODE,
        A.*
 FROM KOPO_CUSTOMERDATA A;
 
 
 
 -- TRIM : 공백제거 *중요*
 -- *중요* TRIM 후 NULL 체크
 -- cf) 로그인할 때 공백 제거 시 유용 ex. UPPER(TRIM(id))
 
-- 4
 SELECT LENGTH('AAAA') AS CASE1
FROM DUAL;

-- 11
SELECT LENGTH('   AAAA    ') AS CASE1
FROM DUAL;

--4
SELECT LENGTH(TRIM('   AAAA    ')) AS  CASE1
FROM DUAL;



-- REPLACE : 교체

-- A60
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW A;

-- A60 -> NATION_60
SELECT REPLACE(A.REGIONID, 'A', 'NATION_') AS REGIONID,
       PRODUCT,
       YEARWEEK,
       QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW A;


-- 총 정리 실습
-- KOPO_CUSTOMERDATA의 고객코드는10자리이다
-- 만약 10자리가 아니면 왼쪽에 0으로 채운다
--이후 고객코드의 뒷 4자리는 암호화를 위해 * 처리를 해야합니다
-- HINT: SUBSTR, LPAD, REPLACE 활용

-- 전체 조회
SELECT *
FROM KOPO_CUSTOMERDATA;

-- TRIM 후 왼쪽을 0으로 채워 10자리 만들기
SELECT 
    LPAD(TRIM(CUSTOMERCODE), 10, '0'),
    A.*
FROM KOPO_CUSTOMERDATA A;

-- 암호화를 위한 고객코드의 뒷 4자리 추출
SELECT 
    SUBSTR(LPAD(TRIM(CUSTOMERCODE), 10, '0'), 7, 4),
    A.*
FROM KOPO_CUSTOMERDATA A;

-- TRIM 후 왼쪽을 0으로 채워 10자리 만든 것에서 암호화 할 4자리를 '****'로 교체
SELECT 
    REPLACE(LPAD(TRIM(CUSTOMERCODE), 10, '0'),SUBSTR(LPAD(TRIM(CUSTOMERCODE), 10, '0'), 7, 4),'****') AS CSCODE,
    A.*
FROM KOPO_CUSTOMERDATA A; 







