-- 숫자 함수
-- ROUND 주어진 숫자를 반올림 한 후 출력함 ex) ROUND(12.345,2) -> 12.35
-- CEIL 주어진 숫자와 가장 근접한 큰 정수 출력함 ex) CEIL(12.345) -> 13
-- FLOOR 주어진 숫자와 가장 근접한 작은 정수 출력함  ex) FLOOR(12.345) -> 12
-- MOD 주어진 숫자를 나누기 한 후 나머지 값 출력함  ex) MOD(12,10) -> 2
-- POWER 주어진 숫자1의 숫자2 승을 출력 ex) POWER(3,2) -> 9

-- 실습
-- NUMBER_EXAMPLE 테이블에서 FIRST/SECOND NUMBER를 활용하여 아래와 같은 결과를 출력하세요
SELECT A.FIRST_NUMBER,
       A.SECOND_NUMBER,
       A.FIRST_NUMBER/A.SECOND_NUMBER AS AVG,
       ROUND(A.FIRST_NUMBER/A.SECOND_NUMBER) AS ROUND_EX,
       CEIL(A.FIRST_NUMBER/A.SECOND_NUMBER) AS CEIL_EX,
       FLOOR(A.FIRST_NUMBER/A.SECOND_NUMBER) AS FLOOR_EX,
       MOD(A.FIRST_NUMBER, A.SECOND_NUMBER) AS MOD_EX,
       POWER(A.FIRST_NUMBER,A.SECOND_NUMBER) AS POWER_EX
FROM NUMBER_EXAMPLE A;

-- ABS : 숫자 데이터의 절대값 반환 함수

-- 실습
-- RMSE_MAE_EXAMPLE2 테이블에서
-- ACCURACY = 1 – ABS(예측값-실제값) / 예측값
-- 공식을 활용하여 정확도를 산출하세요 (소수점 2째자리 반올림)

SELECT A.YEARWEEK,
       A.ACTUAL,
       A.FCST,
       ROUND((1 - ABS(A.FCST-A.ACTUAL)/A.FCST)*100, 2) AS ACCURACY 
FROM RMSE_MAE_EXAMPLE2 A;

-- 교수님 예제
SELECT A.*,
        ABS(A.PREDICTION-A.QTY) AS DIFF, -- 예측값에서 실제값을 뺀 값에 절대값 처리
        1-ABS(A.PREDICTION-A.QTY) AS ACC1, -- 1에서 틀린 것만큼을 뺀 값이 정확도가 되는 것
        1-ABS(A.PREDICTION-A.QTY) / A.PREDICTION AS ACCURACY -- ACCURACY
FROM RMSE_MAE_EXAMPLE A;

-- 날짜함수
-- cf) 배치 프로그램 만들 때 도움이 된다

-- SYSDATE :  시스템 현재 날짜/시간 날짜

SELECT A.*,
        SYSDATE AS TIME_TAG
FROM KOPO_PRODUCT_VOLUME A;

SELECT SYSDATE
FROM DUAL;

-- NEXT_DAY
-- : 다음으로 돌아오는 요일의 날짜 출력
:--  1(일), 2(월), 3(화), 4(수), 5(목), 6(금), 7(토)
-- : NEXT_DAY(SYSDATE,1)

-- LAST_DAY
-- : 속한 달의 마지막 날짜 날짜

SELECT
    SYSDATE,
    NEXT_DAY(SYSDATE, 2),
    LAST_DAY(SYSDATE)
FROM DUAL;

-- 형변환

-- 숫자 -> 문자 : TO_CHAR
-- 문자 -> 숫자 : TO_NUMBER
-- 날짜 -> 문자 : TO_CHAR
-- 문자 -> 날짜 : TO_DATE

SELECT A.*,
	SUBSTR(A.YEARWEEK, 0, 4) AS YEAR,
	SUBSTR(A.YEARWEEK, 5, 2 ) AS WEEK1
	TO_NUMBER ( SUBSTR(A.YEARWEEK, 5, 2 ) AS WEEK2
FROM KOPO_PRODUCT_VOLUME A
ORDER BY WEEK1; 

SELECT A.*,
	SUBSTR(A.YEARWEEK, 0, 4) AS YEAR,
	SUBSTR(A.YEARWEEK, 5, 2 ) AS WEEK1
	TO_NUMBER ( SUBSTR(A.YEARWEEK, 5, 2 ) AS WEEK2
FROM KOPO_PRODUCT_VOLUME A
ORDER BY WEEK2; 

SELECT A.*,
	SUBSTR(A.YEARWEEK, 0, 4) AS YEAR,
	MOD ( SUBSTR(A.YEARWEEK, 5, 2 ), 4 ) AS WEEK1
	MOD ( TO_NUMBER ( SUBSTR(A.YEARWEEK, 5, 2 ) ), 4 ) AS SIGNAL 
FROM KOPO_PRODUCT_VOLUME A
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK; 
-- 문자에 숫자 연산인 MOD 연산을 썼기 때문에 에러가 나야하는데, 오라클 sql이라서 나지 않았다.
-- 다른 db에서는 에러나기 때문에 유의해야한다.
-- MOD 연산을 통해 규칙적인 패턴을 알 수 있다. (물건 전달, 카드 배송 등)  

-- 일반함수
-- CASE : 조건에 맞는경우 WHEN절 값으로 치환 
-- DECODE : SWITCH CASE 문과 같음
-- NVL :  NULL 값을 만나면 다른값으로 치환 NVL(PRODUCT, NULL) (중요)
-- NVL2 : NULL이 아닐경우 A NULL일 경우 B로 치환 NVL2(A.VOLUME,  A.VOLUME, 20 )

-- 조건문
-- CASE WHEN 조건1 THEN 결과1
--         WHEN 조건2 THEN 결과2
--         ELSE 결과3
-- END "컬럼명" 

SELECT
    YEARWEEK,
        CASE WHEN QTY<1000 THEN 1000
                WHEN QTY>1000 AND QTY <10000 THEN 10000
                ELSE 30000 END AS QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW;

SELECT A.REGIONID,
            A.PRODUCT,
            A.QTY,
            CASE WHEN A.QTY < 0 THEN 0
                    WHEN A.QTY > 1000000 THEN 1000000
	        ELSE A.QTY
	END AS REFINED_QTY -- END 누락 주의
FROM KOPO_CHANNEL_SEASONALITY_NEW A;

-- 검증 쿼리 (습관 들이기)
SELECT *
FROM
(	
    SELECT A.REGIONID,
        A.PRODUCT,
        A.QTY,
        CASE WHEN A.QTY < 0 THEN 0
        WHEN A.QTY > 1000000 THEN 1000000
        ELSE A.QTY
        ND AS REFINED_QTY -- END 누락 주의
    FROM KOPO_CHANNEL_SEASONALITY_NEW A;
)
WHERE 1=1
AND QTY < 0 -- 0보다 작은 것들 중에서
AND REFINED_QTY != 0; -- 0인 것이 하나도 없어야 한다.

-- DECODE ( 컬럼명
--	,CASE#1, VALUE#1
--	,CASE#2, VALUE#2
--	, OTHERS)

SELECT A.*,
	,DECODE(A.GENDER, 'Male', 1, 'Female', 2, 0) AS SORT_ORDER
	FROM KOPO_CUSTOMERDATA A
WHERE 1=1
ORDER BY  SORT_ORDER

-- 실습
-- KOPO_CUSTOMERDATA 테이블에서
-- TOTAL_AMOUNT가 10만 이상인경우 HIGH
-- 이외에는 LOW 라는 CUSTOMER_SEG 컬럼을 생성하세요

SELECT A*,
    CASE WHEN TOTAL_AMOUNT >= 100000 THEN 'HIGH'
        ELSE TOTAL_AMOUNT < 100000 THEN 'LOW'
        END AS CUSTOMER_SEG
FROM KOPO_CUSTOMERDATA A;

-- 실습
-- DT_RESULT_FINAL3 테이블에서
-- 정확도를 산출하세요
-- 단, 예측값이 0인경우 정확도는 0
-- 정확도 = 1- ABS(예측값-실측값)/예측값

SELECT A.*,
    CASE WHEN  A.PREDICTION_QTY = 0 THEN 0 
    ELSE 1-ABS(A.PREDICTION_QTY-REAL_QTY)/A.PREDICTION_QTY 
    END AS ACCURACY
FROM DT_RESULT_FINAL3 A;

-- 검증 쿼리
SELECT *
FROM (
    SELECT A.*,
        CASE WHEN A.PREDICTION_QTY = 0 THEN 0 
        ELSE 1 - ABS(A.PREDICTION_QTY - A.REAL_QTY) / A.PREDICTION_QTY 
        END AS ACCURACY
    FROM DT_RESULT_FINAL3 A
) 
WHERE ACCURACY != 0
AND (PREDICTION_QTY = 0 OR ((1 - ABS(PREDICTION_QTY - REAL_QTY)) / PREDICTION_QTY) = 0);

-- NVL : NULL 값을 만나면 다른값으로 치환
-- NVL(PRODUCT, NULL)

-- NVL2 : NULL이 아닐경우 A, NULL일 경우 B로 치환 
-- NVL2(A.VOLUME,  A.VOLUME, 20 )

SELECT A.*
    NVL(VOLUME, 20) AS NVL_EX,
    NVL2(VOLUME. VOLUME *
FROM NVL_CHECK A
