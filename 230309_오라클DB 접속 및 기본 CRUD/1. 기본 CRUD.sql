-- 어떤 데이터가 있지? 가 궁금하다
SELECT * 
FROM TABS ;

-- KOPO_STUDENT_2018 내용이 궁금하다
SELECT *
FROM KOPO_STUDENT_2018;

-- 나는 TABLE_NAME 컬럼만 보고싶다
SELECT TABLE_NAME
FROM TABS;


-- 더블클릭이 하고싶다
SELECT [컬럼명, 모든 컬럼인 경우 '*']
FROM [테이블명]

-- CRUD
-- C: CREATE 생성하다
-- R: READ 조회하다
-- U: UPDATE 수정하다
-- D: DELETE 삭제하다

-- CREATE : 테이블을 생성한다.
CREATE TABLE [테이블명] (
[컬럼명] [컬럼타입],
[컬럼명] [컬럼타입]
)

-- 자료를 만드는 방법
CREATE TABLE PRACTICE_TABLE_한지원(
    REGIONID VARCHAR2(100), -- 문자열을 저장하는 지역ID
    PRODUCTID VARCHAR2(100), -- 문자열을 저장하는 상품ID
    QTY NUMBER 
)

-- 테이블명 : TABLE PRACTICE_TABLE_한지원 (한글을 사용하는 건 지양.)
-- VARCHAR2(100) : 최대 길이가 100개인 문자가 들어올 수 있다는 의미
-- NUMBER : 숫자가 들어온다는 의미

 -- 테이블의 껍데기가 만들어진 것
SELECT *
FROM PRACTICE_TABLE_한지원

-- R 조회 (중요하고, 나중에 집중적으로 배울만한 포인트)
SELECT [컬럼명, 전체 컬럼 조회 시 '*']
FROM [테이블명]
WHERE [조건] 
AND [조건2]

-- 어떤 테이블에서 : FROM
-- 어떤 조건으로 : WHERE
-- 어떤 열을 조회하겠다 : SELECT

-- 거래량이 30만건 이상인 데이터만 찾아줘!
SELECT *
FROM KOPO_PRODUCT_VOLUME -- 거래정보 테이블!
WHERE VOLUME >= 300000 

-- 거래량이 30만건 이상인 데이터만 찾아줘! + 2014년 01주차의 정보만 알고싶다
SELECT *
FROM KOPO_PRODUCT_VOLUME -- 거래정보 테이블!
WHERE VOLUME >= 300000
AND YEARWEEK = 201401 -- 추가된 조건을 AND로 추가

-- 데이터 베이스에서는 쌍따옴표가 안되기 때문에 문자는 '201401'과 같이 표현
-- cf) and 위주로 머리를 정리하자. 실무에서는 or는 딱히 안쓴다고 하셨다.

-- UPDATE 수정
UPDATE [테이블명]
SET [컬럼명] = '변경값'
WHERE [조건명]

-- 어떤 테이블에서 : UPDATE
-- 어떤 조건에 맞는 데이터만 : WHERE
-- 해당 컬럼에 대해서 변경하겠다 : SET

-- 생산 케파가 50만개인데, 
-- 생산 예측 테이블에 50만 건 이상의 데이터가 조회되는 경우에 수정이 필요하다.
-- 김대리 현재 데이터에서 50만건이상으로 나온 데이터를 전부 50만으로 바꿔줘!

SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE VOLUME >= 500000

UPDATE KOPO_PRODUCT_VOLUME
-- VOLUME 변경 20230309 주차별 최대 거래랑 50만 제한
SET VOLUME = '500000'
WHERE VOLUME >= 500000

-- 테이블에 데이터 추가 Update 안에 포함되는 구문!
SELECT *
FROM PRACTICE_TABLE_한지원 -- 조회 먼저

-- INSERT 삽입
INSERT INTO PRACTICE_TABLE_한지원
VALUES ('서울지점','국민카드',300)

-- 두군데만 넣고싶다
INSERT INTO PRACTICE_TABLE_한지원
(REGIONID, QTY) -- 컬럼명 추가
VALUES ('대전지점', 1000)

-- DELETE 삭제

DELETE
FROM [테이블명]
WHERE [조건]

-- 어떤 테이블에서 : FROM
-- 어떤 조건의 : WHERE
-- 어떤 내용을 삭제하겠다 : DELETE

-- 고객데이터에서 장치사용건수가 5건 이상 사용자들만 뽑아줘
-- 일단 있다는 것을 확인해보면 96건 확인된다.
SELECT * 
FROM CUSTOMERDATA
WHERE DEVICECOUNT >= 5

DELETE
FROM [테이블명]
WHERE [조건]

-- 5건 이하인 것들을 삭제처리한다
DELETE
FROM CUSTOMERDATA
WHERE DEVICECOUNT < 5

-- CUSTOMERDATA 테이블
-- AVGPRICE : 평균 구매 금액
-- EMI : 무이자할부
-- DEVICECOUNT : 제품 구입 횟수
-- PRODUCTAGE : 제품 구입 후 사용 주기

