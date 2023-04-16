-- 퀴즈 1번
SELECT A.REGIONID||'_'||A.PRODUCTGROUP AS IDX,
       A.*
FROM KOPO_PRODUCT_VOLUME A;

-- 퀴즈 2번 (상당히 많이 사용)
SELECT *
FROM PRO_PROMOTION
WHERE ITEM IN (SELECT CONCAT(ITEM_PREFIX,ITEM_CODE) AS ITEM
               FROM PRO_RECALL_ITEM);
               
-- 퀴즈 2번 쿼리 검증
-- 현재 아이템 목록 확인 가능
SELECT DISTINCT ITEM
FROM    (SELECT *
         FROM PRO_PROMOTION
         WHERE ITEM IN (SELECT CONCAT(ITEM_PREFIX,ITEM_CODE) AS ITEM
                        FROM PRO_RECALL_ITEM)
        );