-- # �����Լ�
-- �׷�Ưȭ�� �ƴϱ� ������ ���� ���� �� ���� �ȴ�.

SELECT SUM(QTY) AS SUM_QTY,
        MAX(YEARWEEK) AS MAX_YEARWEEK,
        MIN(YEARWEEK) AS MIN_YEARWEKK,
        COUNT(QTY) AS QTY_COUNT
FROM KOPO_CHANNEL_SEASONALITY_NEW;

-- RECORD COUNT
-- COUNT �Լ��� ��������� �Ʒ��� ���� ���ȴ�
SELECT COUNT(*)
FROM KOPO_CHANNEL_SEASONALITY_NEW;

SELECT COUNT(*)
FROM (SELECT *
      FROM KOPO_CHANNEL_SEASONALITY_NEW);

-- # GROUP BY
-- GROUP BY KEY�� ����ϴ� ���, �׻� �� Ű�� OUTPUT���� ���´ٴ� ���� ����

-- �⺻ ����
SELECT REGIONID, SUM(QTY) AS SUM_QTY -- GROUP BY KEY�� SELECT �� �տ� ���;� �Ѵ�.
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID;

-- ���� ) GROUP BY KEY�� SELECT�� ������ �ʾұ� ������
-- ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID;

-- ������ ���踦 Ȯ���ϰ� ���� ���
-- GROUP BY�� REGIONID
-- SELECT�� REGIONID
SELECT REGIONID,
       SUM(QTY) AS SUM_QTY,
       MAX(QTY) AS MAX_QTY,
       MIN(QTY) AS MIN_QTY,
       AVG(QTY) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID
ORDER BY SUM(QTY) DESC; 

-- GROUP BY KEY�� ���� �����
-- �׻� �� Ű�� �ƿ�ǲ���� ���´ٴ� ���� �����ؾ��Ѵ�.
SELECT REGIONID, PRODUCT, 
       SUM(QTY) AS SUM_QTY,
       MAX(QTY) AS MAX_QTY,
       MIN(QTY) AS MIN_QTY,
       AVG(QTY) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT
ORDER BY SUM(QTY) DESC;

-- �ŷ�ó���� �ŷ����� Ȯ���ϰ� ���� ���
SELECT ACCOUNTNAME, COUNT(*) AS COUNT
FROM KOPO_CHANNEL_RESULT
GROUP BY ACCOUNTNAME;

-- ���� ) GROUP BY���� WHERE ���� ��� X, HAVING�� ����ؾ� �Ѵ�. 
-- ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ�
SELECT ACCOUNTNAME, COUNT(*)
FROM KOPO_CHANNEL_RESULT
GROUP BY ACCOUNTNAME
WHERE 1=1
AND ACCOUNT_COUNT > 10000;

-- # HAVING
-- HAVING : GROUP BY ������ ���� ������ �ȴ�.
-- �����Լ��� ���� ������ ����� �� �ִ�.
-- �����Լ� �ڿ��� HAVING�� ����� �� �ִ�.
SELECT ACCOUNTNAME, COUNT(*) AS COUNT
FROM KOPO_CHANNEL_RESULT
GROUP BY ACCOUNTNAME
HAVING COUNT(QTY) > 10000;

-- # WHERE ������ GROUP BY
-- ��ȸ�ϰ� ���� ������ üũ �� �ŷ�ó �� ���� ��ȸ ��ư�� ��������
-- GROUP BY �ϱ� ���� WHERE ����ؼ� �����Ͱ� ���� ����� ������ ��������.
-- ��ȸ�ϰ� ���� A01, A02, A03, A04�� ���� ���ϰ� �׷캰�� ����
SELECT ACCOUNTNAME, COUNT(QTY) AS ACCOUNT_COUNT
FROM KOPO_CHANNEL_RESULT
WHERE AP2ID IN ('A01', 'A02', 'A03', 'A04')
GROUP BY ACCOUNTNAME
HAVING COUNT(QTY) > 10000;

-- HAVING�� ������� �ʰ�,
-- ���������� �־ ��ȸ�� �Ϳ� WHERE �Ἥ ��ȸ�ϴ� �͵� �����ϴ�
SELECT *
FROM
(
    SELECT ACCOUNTNAME, COUNT(QTY) AS ACCOUNT_COUNT
    FROM KOPO_CHANNEL_RESULT
    WHERE AP2ID IN ('A01', 'A02', 'A03', 'A04')
    GROUP BY ACCOUNTNAME
)
WHERE ACCOUNT_COUNT > 10000;

-- cf) CTRL + E
-- EXPLAIN PLAN
-- COST ���� ���´�
-- COST�� ������ �������� ����
-- COST�� ũ�� CPU �ڿ��� ���� ����

-- # ��������
-- cf) JOIN�� ������������ ������ ����
-- 1. FROM���� ��������
-- 2. WHERE���� ��������
-- 3. SELECT���� ��������

-- 1. FROM���� ��������

SELECT *
FROM 
(
    SELECT ACCOUNTNAME,COUNT(QTY) AS ACCOUNT_COUNT
    FROM KOPO_CHANNEL_RESULT
    WHERE AP2ID IN ('A01', 'A02', 'A03', 'A04')
    GROUP BY ACCOUNTNAME
)
WHERE ACCOUNT_COUNT > 10000;


-- ������ ������ ���ο� �÷��� ������µ�
-- �� �÷��� Ȱ���ؼ� Ȱ���ϰ� �ʹٸ�
-- ���� ������ Ȱ���ؾ� �Ѵ�.
SELECT *
FROM 
(
    SELECT ACCOUNTNAME,
            'KOPO_'||ACCOUNTNAME AS NEW_ACCOUNT,
            COUNT(QTY) AS ACCOUNT_COUNT
    FROM KOPO_CHANNEL_RESULT
    WHERE AP2ID IN ('A01', 'A02', 'A03', 'A04')
    GROUP BY ACCOUNTNAME
)
WHERE NEW_ACCOUNT LIKE 'KOPO_A%';

-- 2. WHERE���� ��������
-- ���̺� == ��������
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND REGIONID IN ('A01', 'A02');

SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
--AND REGIONID IN ('A01', '1')
AND REGIONID IN (SELECT DISTINCT REGIONID -- DISTINCT�� �̸� �ɸ� ����
                 FROM KOPO_PRODUCT_VOLUME);
                 
-- ���� ���� �κп��� DISTINCT�� �Ŵ� ������
SELECT COUNT(*)
FROM KOPO_PRODUCT_VOLUME;
-- ����� 831�ǹۿ� ���� ������
-- �� ���� �����Ͱ� �ִٸ� �Ҹ����� �� �ִ�.

-- �������� ���ÿ� expression Ȱ�� ����
-- �����ؼ� ����ϴ� �͵� �����ϴ�
-- A01, A44�� �ִµ� prefix�� ���� ���¶��
-- �Ʒ��� ���� expression ����ؼ� ��ȸ�� �� �ִٴ� ���� �����ؾ� �Ѵ�.
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
--AND REGIONID IN ('KOPO_A01', 'KOPO_A41')
AND 'KOPO_'||REGIONID IN (SELECT REGIONID 
                          FROM REGION_MST_HK);
                                        
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
--AND REGIONID IN ('KOPO_A01', 'KOPO_A41')
AND LPAD(REGIONID, 8, 'KOPO_') IN (SELECT REGIONID -- DISTINCT�� �̸� �ɸ� ����
                                   FROM REGION_MST_HK);
                                   
-- join �� Ȱ��
-- ON LPAD(A.REGIONID, 8, 'KOPO_') = B.REGIONID

-- 3. SELECT �� ��������
-- ����) ���� ���� �����ؾ� �Ѵ�.

-- �Ʒ��� ���� ���̺��� �÷��� �ϳ� �� ����
SELECT A.REGIONID,
       A.PRODUCT,
       A.YEARWEEK,
       A.QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW A;
-- Ư�� ������, Ư�� ��ǰ�� ��� �ŷ����� ���ϰ� �ʹ�
-- REGIONID�� PRODUCT�� ���� �� �� ��ǰ�� ��� �ŷ��� 

-- ��� 1. SELECT �� ��������
SELECT A.REGIONID,
       A.PRODUCT,
       A.YEARWEEK,
       A.QTY,
       (SELECT AVG(B.QTY)
        FROM KOPO_CHANNEL_SEASONALITY_NEW B
        WHERE 1=1
        AND B.REGIONID = A.REGIONID
        AND B.PRODUCT = A.PRODUCT
        ) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW A;

-- �������� ���� ��
-- AVG_QTY���� 44.8461538461538
SELECT AVG(B.QTY) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW B
WHERE 1=1
AND B.REGIONID = 'A60'
AND B.PRODUCT = 'PRODUCT4';

-- 4.8461538461538��� ���� SELECT�ؼ� ����� ���� ��. 
-- REGIONID�� PRODUCT�� ���� ��쿡 Ư�� ���� �ʿ��� ���̴�.
-- (�츮�� �ʿ��� �� Ư�� ������, Ư�� ��ǰ�� ��� �ŷ���)
-- WHERE ������ ���� ������ ���� �� ���� ���� ������ �ȴ�.
-- ������ ��ǰ�� ��� ���� ��ü �������� ��հ��� ���´�. (8949.96149246667)
-- ��ü ���̺��� B��� �ΰ� B ���̺� A�� REGIONID�� ����;� �Ѵ�.

-- ���2. join ���

-- STEP1. ����, ��ǰ�� ��� �Ǹŷ��� ���Ѵ�
SELECT REGIONID,
       PRODUCT,
       AVG(QTY) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT;

-- STEP2. ���� ���������Ϳ� ����Ű (����, ��ǰ) Ű�� �����͸� �����Ѵ�.
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW A
LEFT JOIN ( 
            SELECT REGIONID,
                   PRODUCT,
                   AVG(QTY) AS AVG_QTY
            FROM KOPO_CHANNEL_SEASONALITY_NEW
            GROUP BY REGIONID, PRODUCT
           ) B
ON A.REGIONID = B.REGIONID
AND A.PRODUCT = B.PRODUCT;

-- STEP3. ����
SELECT A.REGIONID, A.PRODUCT, A.YEARWEEK, A.QTY, B.AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW A
LEFT JOIN ( 
            SELECT REGIONID,
                   PRODUCT,
                   AVG(QTY) AS AVG_QTY
            FROM KOPO_CHANNEL_SEASONALITY_NEW
            GROUP BY REGIONID, PRODUCT
           ) B
ON A.REGIONID = B.REGIONID
AND A.PRODUCT = B.PRODUCT;

-- 4. WITH ��������
-- �޸� ������� ������ �����Ѵ�
-- ��ũ ������� ������ �����ϸ� ���� ���ۿ� ����.

WITH A AS
( 
SELECT * FROM KOPO_CHANNEL_RESULT
)
SELECT * FROM A;

SELECT *
FROM ( SELECT *
       FROM KOPO_CHANNEL_RESULT
       WHERE 1=1
       AND AP2ID IN ('A01','A02')
);

-- # ����
--  Ȱ�� ��õ ���̺� (KOPO_CHANNEL_RESULT, KOPO_CHANNEL_SEASONALITY_NEW)
-- ������ ���� ������ �����ؾ� �Ѵ�. (���������� �����ͷ��� ������ �� �ִ�)

-- RECORD COUNT
-- 124646
SELECT COUNT(*)
FROM KOPO_CHANNEL_SEASONALITY_NEW;

-- LEFT JOIN
-- ���� �����ʹ� �� ����� �ϱ� ������ ������ �Ǵ� �������� ������ �����ؾ� �Ѵ�.
SELECT A.*, B.*
FROM KOPO_CHANNEL_SEASONALITY_NEW A
LEFT JOIN KOPO_REGION_MST B
ON A.REGIONID = B.REGIONID;

-- LEFT JOIN
-- 124646
SELECT COUNT(*)
FROM (SELECT A.*, B.*
      FROM KOPO_CHANNEL_SEASONALITY_NEW A
      LEFT JOIN KOPO_REGION_MST B
      ON A.REGIONID = B.REGIONID);


-- KOPO_CHANNEL_SEASONALITY_NEW���� A77 ������ ������,
-- KOPO_REGION_MST���� A77 ������ ����.
-- KOPO_REGION_MST�� REGIONID���� ���Ե��� ���� 
-- KOPO_CHANNEL_SEASONALITY_NEW�� REGIOND�� ��ȸ�� �����̴�.
-- �ϱ�
SELECT DISTINCT A.REGIONID
FROM KOPO_CHANNEL_SEASONALITY_NEW A
WHERE 1=1
AND A.REGIONID NOT IN (SELECT REGIONID
                      FROM KOPO_REGION_MST);

-- INNER JOIN
-- �����տ� �ش��ϴ� �����͸� ��ȸ�ȴ�.
SELECT A.*, B.*
FROM KOPO_CHANNEL_SEASONALITY_NEW A
INNER JOIN KOPO_REGION_MST B
ON A.REGIONID = B.REGIONID;

-- INNER JOIN
-- 124332
SELECT COUNT(*)
FROM (SELECT A.*, B.*
      FROM KOPO_CHANNEL_SEASONALITY_NEW A
      INNER JOIN KOPO_REGION_MST B
      ON A.REGIONID = B.REGIONID);

-- �� �����Ϳ� 314��� ���̰� �ִ�.
-- KOPO_CHANNEL_SEASONALITY_NEW���� A77 ������ ������,
-- KOPO_REGION_MST���� A77 ������ ���� �����̴�. 
-- KOPO_REGION_MST�� REGIONID���� ���Ե��� ���� 
-- KOPO_CHANNEL_SEASONALITY_NEW�� REGIOND�� ��ȸ�� �����̴�.
-- �ϱ�
SELECT DISTINCT A.REGIONID
FROM KOPO_CHANNEL_SEASONALITY_NEW A
WHERE 1=1
AND A.REGIONID NOT IN (SELECT REGIONID
                      FROM KOPO_REGION_MST);

-- A77 ������ ������ ��
-- 314
SELECT COUNT(*)                     
FROM (SELECT A.REGIONID
        FROM KOPO_CHANNEL_SEASONALITY_NEW A
        WHERE 1=1
        AND A.REGIONID NOT IN (SELECT REGIONID
                                FROM KOPO_REGION_MST));

-- 0
SELECT COUNT(*)
FROM (SELECT A.*, B.*
      FROM KOPO_CHANNEL_SEASONALITY_NEW A -- A77 ������ �ִ�
      INNER JOIN KOPO_REGION_MST B -- A77 ������ ����
      ON A.REGIONID = B.REGIONID
      WHERE 1=1
      AND A.REGIONID = 'A77');
      
      
      
-- RIGHT JOIN
-- ������ ������(���̴� ������)�� �츮�� ��
SELECT A.*, B.*
FROM KOPO_CHANNEL_SEASONALITY_NEW A
RIGHT JOIN KOPO_REGION_MST B
ON A.REGIONID = B.REGIONID;

-- RIGHT JOIN
-- 124337 
SELECT COUNT(*)
FROM (SELECT A.*, B.*
      FROM KOPO_CHANNEL_SEASONALITY_NEW A
      RIGHT JOIN KOPO_REGION_MST B
      ON A.REGIONID = B.REGIONID);
 
-- KOPO_CHANNEL_SEASONALITY_NEW �� ������ ���� ���� REGIONID�� ã��   
SELECT DISTINCT REGIONID
FROM KOPO_CHANNEL_SEASONALITY_NEW;

-- KOPO_REGION_MST�� �߰������� ������ �ִ� REGIONID���� �� �� �ִ�.
-- A30, A99, A49, A71, A931
SELECT A.REGIONID
FROM KOPO_REGION_MST A
WHERE 1=1
AND A.REGIONID NOT IN ( SELECT DISTINCT REGIONID
                        FROM KOPO_CHANNEL_SEASONALITY_NEW);

-- RIGHT �����͸� ������ �ִ�
-- A30, A99, A49, A71, A931 ������ ������ ��
SELECT COUNT(*)
FROM (SELECT A.REGIONID
      FROM KOPO_REGION_MST A
      WHERE 1=1
      AND A.REGIONID NOT IN ( SELECT REGIONID
                              FROM KOPO_CHANNEL_SEASONALITY_NEW));

-- 0
SELECT COUNT(*)
FROM (SELECT A.*, B.*
      FROM KOPO_CHANNEL_SEASONALITY_NEW A -- A77 ������ �ִ�
      INNER JOIN KOPO_REGION_MST B -- A77 ������ ����
      ON A.REGIONID = B.REGIONID
      WHERE 1=1
      AND A.REGIONID = 'A30');                               
                                   
-- FULL OUTER JOIN
-- 124651
-- ���ʿ���, �����ʿ��� �ִ� ��� ������ ���Խ��Ѽ� ����Ѵ�.

SELECT A.*, B.*
FROM KOPO_CHANNEL_SEASONALITY_NEW A
FULL OUTER JOIN KOPO_REGION_MST B
ON A.REGIONID = B.REGIONID;

SELECT COUNT(*)
FROM (SELECT A.*, B.*
      FROM KOPO_CHANNEL_SEASONALITY_NEW A
      FULL OUTER JOIN KOPO_REGION_MST B
      ON A.REGIONID = B.REGIONID);


-- 124646
--INNER 124332
--LEFT 124646
--RIGHT 124337
--FULL OUTER JOIN 124651 

-- ���̺� �� ���� ������ ����
SELECT C.*
FROM(
      SELECT A.*, B.REGIONNAME
      FROM KOPO_CHANNEL_SEASONALITY_NEW A -- A77 ������ �ִ�
      LEFT JOIN KOPO_REGION_MST B -- A77 ������ ����
      ON A.REGIONID = B.REGIONID
      WHERE 1=1
) C
INNER JOIN KOPO_REGION_MST D
ON C.REGIONID = D.REGIONID;

--124332
SELECT COUNT(*)
FROM (SELECT C.*
      FROM(
            SELECT A.*, B.REGIONNAME
            FROM KOPO_CHANNEL_SEASONALITY_NEW A -- A77 ������ �ִ�
            LEFT JOIN KOPO_REGION_MST B -- A77 ������ ����
            ON A.REGIONID = B.REGIONID
            WHERE 1=1
            ) C     
       INNER JOIN KOPO_REGION_MST D
       ON C.REGIONID = D.REGIONID);









