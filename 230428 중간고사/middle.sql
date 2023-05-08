-- 1번

CREATE TABLE KOPO_MIDDLE_2023_한지원_2 AS
SELECT *
FROM (
      SELECT A.PRD_SEG1 AS SEG1, A.PRD_SEG2 AS SEG2, CONCAT('11',A.PRD_SEG3) AS SEG3, CONCAT(A.YEAR, A.WEEK) AS TARGEWEEK, A.YEAR, A.WEEK, A.QTY, B.OUTFCST AS FCST_W6, FCST_W5, FCST_W4, FCST_W3, A.FCST_W2, A.FCST_W1
        FROM ( SELECT  A.PRD_SEG1, A.PRD_SEG2, A.PRD_SEG3, A.YEAR, A.WEEK, A.QTY, B.OUTFCST AS FCST_W5, FCST_W4, FCST_W3, A.FCST_W2, A.FCST_W1
                FROM (  SELECT A.PRD_SEG1, A.PRD_SEG2, A.PRD_SEG3, A.YEAR, A.WEEK, A.QTY, B.OUTFCST AS FCST_W4, FCST_W3, A.FCST_W2, A.FCST_W1
                        FROM ( SELECT A.PRD_SEG1, A.PRD_SEG2, A.PRD_SEG3, A.YEAR, A.WEEK, A.QTY, B.OUTFCST AS FCST_W3, A.FCST_W2, A.FCST_W1
                                FROM ( SELECT A.PRD_SEG1, A.PRD_SEG2, A.PRD_SEG3, A.YEAR, A.WEEK, A.QTY, B.OUTFCST AS FCST_W2 , A.OUTFCST AS FCST_W1
                                        FROM KOPO_FINAL_1WEEK A
                                        LEFT JOIN ( SELECT *
                                                    FROM KOPO_FINAL_2WEEK
                                                    WHERE WEEK = 18) B
                                        ON A.PRD_SEG3 = B.PRD_SEG3 
                                        AND A.PRD_SEG1 = B.PRD_SEG1
                                        AND A.PRD_SEG2 = B.PRD_SEG2
                                        AND A.YEAR = B.YEAR
                                        AND A.WEEK = B.WEEK
                                        AND A.QTY = B.QTY ) A
                                LEFT JOIN ( SELECT *
                                            FROM KOPO_FINAL_3WEEK 
                                            WHERE WEEK = 18) B
                                ON A.PRD_SEG3 = B.PRD_SEG3
                                AND A.PRD_SEG1 = B.PRD_SEG1
                                AND A.PRD_SEG2 = B.PRD_SEG2
                                AND A.YEAR = B.YEAR
                                AND A.WEEK = B.WEEK
                                AND A.QTY = B.QTY ) A
                        LEFT JOIN (SELECT *
                                   FROM KOPO_FINAL_4WEEK
                                   WHERE WEEK = 18) B
                        ON A.PRD_SEG3 = B.PRD_SEG3
                        AND A.PRD_SEG1 = B.PRD_SEG1
                        AND A.PRD_SEG2 = B.PRD_SEG2
                        AND A.YEAR = B.YEAR
                        AND A.WEEK = B.WEEK
                        AND A.QTY = B.QTY ) A
                LEFT JOIN (SELECT *
                           FROM KOPO_FINAL_5WEEK
                           WHERE WEEK = 18) B
                ON A.PRD_SEG3 = B.PRD_SEG3
                AND A.PRD_SEG1 = B.PRD_SEG1
                AND A.PRD_SEG2 = B.PRD_SEG2
                AND A.WEEK = B.WEEK
                AND A.YEAR = B.YEAR
                AND A.QTY = B.QTY ) A 
        LEFT JOIN (SELECT *
                   FROM KOPO_FINAL_6WEEK
                   WHERE WEEK = 18) B
        ON A.PRD_SEG3 = B.PRD_SEG3
        AND A.PRD_SEG1 = B.PRD_SEG1
        AND A.PRD_SEG2 = B.PRD_SEG2
        AND A.YEAR = B.YEAR
        AND A.WEEK = B.WEEK
        AND A.QTY = B.QTY
        ORDER BY A.PRD_SEG1, A.PRD_SEG2, A.PRD_SEG3 )
WHERE SEG3 != '11HAITEAM';

SELECT *
FROM KOPO_MIDDLE_2023_한지원_2
ORDER BY SEG1, SEG2, SEG3;

-- 2번

SELECT A.SEG1, A.SEG2, A.SEG3, A.TARGEWEEK, A.YEAR, A.WEEK, A.QTY, A.FCST_W6, A.FCST_W5, A.FCST_W4, A.FCST_W3, FCST_W2, FCST_W1,
       A.ABS8W_W6, A.ABS8W_W5, A.ABS8W_W4, A.ABS8W_W3, A.ABS8W_W2, A.ABS8W_W1,
       A.ACC8W_W6, A.ACC8W_W5, A.ACC8W_W4, A.ACC8W_W3, A.ACC8W_W2, A.ACC8W_W1,
       SUM_FCST/COUNT_FCST AS FCST_AVG,
       SUM_ACC8W/COUNT_ACC8W AS ACC_AVG
FROM ( SELECT A.*,
       NVL(A.FCST_W6,0)+NVL(A.FCST_W5,0)+NVL(A.FCST_W4,0)+NVL(A.FCST_W3,0)+NVL(A.FCST_W2,0)+NVL(A.FCST_W1,0) AS SUM_FCST,
       NVL2(A.FCST_W6,1,0)+NVL2(A.FCST_W5,1,0)+NVL2(A.FCST_W4,1,0)+NVL2(A.FCST_W3,1,0)+NVL2(A.FCST_W2,1,0)+NVL2(A.FCST_W1,1,0) AS COUNT_FCST,
       NVL(A.ACC8W_QTY_W6,0)+NVL(A.ACC8W_QTY_W5,0)+NVL(A.ACC8W_QTY_W4,0)+NVL(A.ACC8W_QTY_W3,0)+NVL(ACC8W_QTY_W2,0)+NVL(ACC8W_QTY_W1,0) AS SUM_ACC8W,
       NVL2(A.ACC8W_QTY_W6,1,0)+NVL2(A.ACC8W_QTY_W5,1,0)+NVL2(A.ACC8W_QTY_W4,1,0)+NVL2(A.ACC8W_QTY_W3,1,0)+NVL2(ACC8W_QTY_W2,1,0)+NVL2(ACC8W_QTY_W1,1,0) AS COUNT_ACC8W
FROM ( SELECT  A.*,
            CASE WHEN TRIM(FCST_W6 * ACC8W_W6) = 0 THEN 0
                 WHEN TRIM(FCST_W6 * ACC8W_W6) IS NULL THEN 0
                 ELSE FCST_W6 * ACC8W_W6
                 END AS ACC8W_QTY_W6,
            CASE WHEN TRIM(FCST_W5 * ACC8W_W5) = 0 THEN 0
                 WHEN TRIM(FCST_W5 * ACC8W_W5) IS NULL THEN 0
                 ELSE FCST_W5 * ACC8W_W5
                 END AS ACC8W_QTY_W5, 
            CASE WHEN TRIM(FCST_W4 * ACC8W_W4) = 0 THEN 0
                 WHEN TRIM(FCST_W4 * ACC8W_W4) IS NULL THEN 0
                 ELSE FCST_W4 * ACC8W_W4
                 END AS ACC8W_QTY_W4,
            CASE WHEN TRIM(FCST_W3 * ACC8W_W3) = 0 THEN 0
                 WHEN TRIM(FCST_W3 * ACC8W_W3) IS NULL THEN 0
                 ELSE FCST_W3 * ACC8W_W3
                 END AS ACC8W_QTY_W3,
            CASE WHEN TRIM(FCST_W2 * ACC8W_W2) = 0 THEN 0
                 WHEN TRIM(FCST_W2 * ACC8W_W2) IS NULL THEN 0
                 ELSE FCST_W2 * ACC8W_W2
                 END AS ACC8W_QTY_W2,
            CASE WHEN TRIM(FCST_W1 * ACC8W_W1) = 0 THEN 0
                 WHEN TRIM(FCST_W1 * ACC8W_W1) IS NULL THEN 0
                 ELSE FCST_W1 * ACC8W_W1
                 END AS ACC8W_QTY_W1
FROM (      
                        SELECT A.*,
                               CASE WHEN TRIM(FCST_W6) = 0 THEN 0
                                    WHEN TRIM(FCST_W6) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W6) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W6) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W6/FCST_W6) > 2 THEN 0
                                    ELSE 1-ABS8W_W6/FCST_W6
                                    END AS ACC8W_W6,
                                CASE WHEN TRIM(FCST_W5) = 0 THEN 0
                                    WHEN TRIM(FCST_W5) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W5) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W5) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W5/FCST_W5) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W5/FCST_W5) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W5/FCST_W5) > 2 THEN 0
                                    ELSE ABS(1-ABS8W_W5/FCST_W5)
                                    END AS ACC8W_W5,
                                CASE WHEN TRIM(FCST_W4) = 0 THEN 0
                                    WHEN TRIM(FCST_W4) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W4) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W4) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W4/FCST_W4) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W4/FCST_W4) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W4/FCST_W4) > 2 THEN 0
                                    ELSE ABS(1-ABS8W_W4/FCST_W4)
                                    END AS ACC8W_W4,
                                CASE WHEN TRIM(FCST_W3) = 0 THEN 0
                                    WHEN TRIM(FCST_W3) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W3) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W3) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W3/FCST_W3) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W3/FCST_W3) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W3/FCST_W3) > 2 THEN 0
                                    ELSE ABS(1-ABS8W_W3/FCST_W3)
                                    END AS ACC8W_W3,
                                CASE WHEN TRIM(FCST_W2) = 0 THEN 0
                                    WHEN TRIM(FCST_W2) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W2) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W2) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W2/FCST_W2) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W2/FCST_W2) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W2/FCST_W2) > 2 THEN 0
                                    ELSE ABS(1-ABS8W_W2/FCST_W2)
                                    END AS ACC8W_W2,
                                CASE WHEN TRIM(FCST_W1) = 0 THEN 0
                                    WHEN TRIM(FCST_W1) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W1) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W1) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W1/FCST_W1) = 0 THEN 0
                                    WHEN TRIM(ABS8W_W1/FCST_W1) IS NULL THEN 0
                                    WHEN TRIM(ABS8W_W1/FCST_W1) > 2 THEN 0
                                    ELSE ABS(1-ABS8W_W1/FCST_W1)
                                    END AS ACC8W_W1
                    FROM ( SELECT A.*, 
                                   NVL2(ABS(A.FCST_W6-A.QTY), ABS(A.FCST_W6-A.QTY) , A.QTY ) AS ABS8W_W6,
                                   NVL2(ABS(A.FCST_W5-A.QTY), ABS(A.FCST_W5-A.QTY) , A.QTY ) AS ABS8W_W5,
                                   NVL2(ABS(A.FCST_W4-A.QTY), ABS(A.FCST_W4-A.QTY) , A.QTY ) AS ABS8W_W4,
                                   NVL2(ABS(A.FCST_W3-A.QTY), ABS(A.FCST_W3-A.QTY) , A.QTY ) AS ABS8W_W3,
                                   NVL2(ABS(A.FCST_W2-A.QTY), ABS(A.FCST_W2-A.QTY) , A.QTY ) AS ABS8W_W2,
                                   NVL2(ABS(A.FCST_W1-A.QTY), ABS(A.FCST_W1-A.QTY) , A.QTY ) AS ABS8W_W1
                            FROM KOPO_MIDDLE_2023_한지원_2 A
                            ORDER BY SEG1, SEG2, SEG3 ) A ) A ) A ) A;