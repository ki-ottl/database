-- PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요. 
-- 이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 
-- 결과는 가격대를 기준으로 오름차순 정렬해주세요.

SELECT PRICE_GROUP, COUNT(PRODUCT_CODE) AS PRODUCTS
FROM (
SELECT A.*,
       CASE WHEN PRICE < 10000 THEN 0
            WHEN PRICE < 20000 THEN 10000
            WHEN PRICE < 30000 THEN 20000
            WHEN PRICE < 40000 THEN 30000
            WHEN PRICE < 50000 THEN 40000
            WHEN PRICE < 60000 THEN 50000
            WHEN PRICE < 70000 THEN 60000
            WHEN PRICE < 80000 THEN 70000
            ELSE 80000
        END AS PRICE_GROUP
FROM PRODUCT A
)
GROUP BY PRICE_GROUP
ORDER BY PRICE_GROUP ASC;

