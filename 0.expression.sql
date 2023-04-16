-- Expression 
-- EXPRESSION 데이터 조회할 때 기존값 외에 추가로 컬럼을 생성할 수 있다.
-- 테이블에 별칭, 컬럼명에 별칭을 줄 수 있다 (AS)
-- ex. 자주 사용하는 식별코드, 타임플래그 폼

SELECT A.*,
    CONCAT('ABC','_') AS NEWCOL,
    1234 AS BACKID,
    'HK_BANK' AS BANKNAME
FROM CUSTOMERDATA A;

SELECT A.*,
    CONCAT(A.CUSTID,A.CUSTTYPE) AS NEWCOL,
    1234 AS BACKID,
    'HK_BANK' AS BANKNAME
FROM CUSTOMERDATA A;

-- 실무에서 많이 사용
-- 오라클 제공 CONCAT 함수는 기본적으로 2개만 가능
SELECT A.*,
    A.CUSTID||'_'||A.CUSTTYPE AS NEWCOL2,
    CONCAT(A.CUSTID,CONCAT('_',A.CUSTTYPE)) AS NEWCOL,
    1234 AS BACKID,
    'HK_BANK' AS BANKNAME
FROM CUSTOMERDATA A;

SELECT A.*,
    SYSDATE AS TIME_CODE,
    'PREDICT_MODEL' AS MEASUREID,
    A.DEVICECOUNT+A.EMI AS NEWCOL3,
    A.CUSTID||'_'||A.CUSTTYPE AS NEWCOL2,
    CONCAT(A.CUSTID,CONCAT('_',A.CUSTTYPE)) AS NEWCOL,
    1234 AS BACKID,
    'HK_BANK' AS BANKNAME
FROM CUSTOMERDATA A;

-- 'PREDICT_MODEL'의 컬럼이름을 MEASUREID로 지어줄 수 있다
-- 'PREDICT_MODEL'을 가장 첫 컬럼에서 보고 싶을 때
SELECT     
    'PREDICT_MODEL' AS MEASUREID,
    A.*,
    SYSDATE AS TIME_CODE,
    A.DEVICECOUNT+A.EMI AS NEWCOL3,
    A.CUSTID||'_'||A.CUSTTYPE AS NEWCOL2,
    CONCAT(A.CUSTID,CONCAT('_',A.CUSTTYPE)) AS NEWCOL,
    1234 AS BACKID,
    'HK_BANK' AS BANKNAME
FROM CUSTOMERDATA A;

-- 내가 만든 컬럼을 먼저 나오게끔 하고,
SELECT 'PREDICT_MODEL' AS MEASUREID, 
    A.*,  -- A 테이블의 모든 컬럼
    SYSDATE AS TIMEFLAG -- 타임플래그
FROM CUSTOMERDATA A

