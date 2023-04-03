-- ORDER BY : �����ϱ�
-- ASC(��������), DESC(��������)
-- cf) QTY DESC�� ���� ���ȴ� 

-- � �����Ϳ� ���ؼ� ���ظ� ���� �ϱ� ���ؼ��� �⺻Ű�� ���� ã�ƾ� �Ѵ�.
-- �⺻Ű�� �ߺ��� ������� �ʴ� Ű�̱� ������,
-- �⺻Ű�� ������ �ϸ�, �����͸� �ϳ��ϳ� �� �� �� �ִ�.

-- ���ľȵ�
 SELECT *
FROM KOPO_CHANNEL_RESULT
ORDER BY YEARWEEK;

-- ���ĵ� (��������)
SELECT AP2ID, SALESID, ITEM, YEARWEEK, QTY
FROM KOPO_CHANNEL_RESULT
ORDER BY AP2ID, SALESID, ITEM, YEARWEEK;

-- ���ĵ� (��������)
SELECT AP2ID, SALESID, ITEM, YEARWEEK, QTY
FROM KOPO_CHANNEL_RESULT
ORDER BY AP2ID, SALESID, ITEM, YEARWEEK DESC;

-- �ǽ� ) OPO_PRODUCT_VOLUME ���̺���
-- ����, ��ǰ, ���� �������� ���·� ��ȸ

-- ��������
SELECT *
FROM KOPO_PRODUCT_VOLUME
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK ASC;

-- ��������
SELECT *
FROM KOPO_PRODUCT_VOLUME
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK DESC;



-- LOWER 
-- Ư�� ������ �ҹ��ڷ� �ٲٰ� �ʹ�
-- �÷��� �̸��� �״�� �ְ�, �Ӽ����� �ٲ��.

 SELECT LOWER(PRODUCTGROUP)
 FROM KOPO_PRODUCT_VOLUME;
 
 SELECT LOWER(PRODUCTGROUP) AS PRODUCTNAME
 FROM KOPO_PRODUCT_VOLUME;
 
 SELECT *
 FROM LOGIN_TABLE
 WHERE ID = UPPER('haiteam');
 
-- MANAGER ��ȸ
SELECT *
FROM LOGIN_TABLE 
WHERE ID = UPPER('manager');

-- manager ��ȸ
SELECT *
FROM LOGIN_TABLE 
WHERE ID = LOWER('MANAGER');



-- CONCAT : ��ħ
-- cf) ����Ŭ �� Ÿ �����ͺ��̽������� ����� ������ �������� Ȯ�� �ʿ�!

SELECT A.*,
       CONCAT(REGIONID,PRODUCTGROUP) AS IDX,
       REGIONID||'_'||PRODUCTGROUP AS IDX2,
       -- �⺻Ű�� ���Ĺ��ȴ�. �ߺ��� Ȯ�� ��, ����.
       CONCAT(REGIONID,CONCAT(PRODUCTGROUP,YEARWEEK)) AS KEY_VALUE
FROM KOPO_PRODUCT_VOLUME A;


-- SUBSTR : ����
-- ���翡 �ִ� �÷����� Ư�� �ε����� �÷����� ������ �� �ִ�.

SELECT SUBSTR(PRODUCTGROUP, 0, 3)
FROM KOPO_PRODUCT_VOLUME;

-- �ǽ� ) KOPO_PRODUCT_VOLUME ���̺��� ����, ����

SELECT SUBSTR(A.YEARWEEK, 1, 4) AS YEAR,
       SUBSTR(A.YEARWEEK, 5, 6) AS WEEK,
       A.*
FROM KOPO_PRODUCT_VOLUME A;

-- ��������Ʈ(5)���� 2���� ���ڸ� ������ ���̶�� �ǹ̶�
-- �̷��� �� �� �ִ�
SELECT SUBSTR(A.YEARWEEK, 1, 4) AS YEAR,
       SUBSTR(A.YEARWEEK, 5, 2) AS WEEK,
       A.*
FROM KOPO_PRODUCT_VOLUME A;



-- LPAD, RPAD : �ڸ���

--LPAD
 SELECT A.*,
        LPAD ( UPPER(CUSTID), 10, '0') AS CSID 
 FROM CUSTOMERDATA A;
 
--RPAD
 SELECT A.*,
        RPAD ( UPPER(CUSTID), 10, '0') AS CSID 
 FROM CUSTOMERDATA A;

-- �ǽ� ) KOPO_CUSTOMERDATA ���̺���
-- CUSTOMERCODE�� 12�ڸ��� ��ȸ�ϼ���
-- ��, 12�ڸ��� �ȵ� ��� �տ� *�� ä�켼��.

 SELECT LPAD( CUSTOMERCODE, 12, '*') AS CSCODE,
        A.*
 FROM KOPO_CUSTOMERDATA A;
 
 
 
 -- TRIM : �������� *�߿�*
 -- *�߿�* TRIM �� NULL üũ
 -- cf) �α����� �� ���� ���� �� ���� ex. UPPER(TRIM(id))
 
-- 4
 SELECT LENGTH('AAAA') AS CASE1
FROM DUAL;

-- 11
SELECT LENGTH('   AAAA    ') AS CASE1
FROM DUAL;

--4
SELECT LENGTH(TRIM('   AAAA    ')) AS  CASE1
FROM DUAL;



-- REPLACE : ��ü

-- A60
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW A;

-- A60 -> NATION_60
SELECT REPLACE(A.REGIONID, 'A', 'NATION_') AS REGIONID,
       PRODUCT,
       YEARWEEK,
       QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW A;


-- �� ���� �ǽ�
-- KOPO_CUSTOMERDATA�� ���ڵ��10�ڸ��̴�
-- ���� 10�ڸ��� �ƴϸ� ���ʿ� 0���� ä���
--���� ���ڵ��� �� 4�ڸ��� ��ȣȭ�� ���� * ó���� �ؾ��մϴ�
-- HINT: SUBSTR, LPAD, REPLACE Ȱ��

-- ��ü ��ȸ
SELECT *
FROM KOPO_CUSTOMERDATA;

-- TRIM �� ������ 0���� ä�� 10�ڸ� �����
SELECT 
    LPAD(TRIM(CUSTOMERCODE), 10, '0'),
    A.*
FROM KOPO_CUSTOMERDATA A;

-- ��ȣȭ�� ���� ���ڵ��� �� 4�ڸ� ����
SELECT 
    SUBSTR(LPAD(TRIM(CUSTOMERCODE), 10, '0'), 7, 4),
    A.*
FROM KOPO_CUSTOMERDATA A;

-- TRIM �� ������ 0���� ä�� 10�ڸ� ���� �Ϳ��� ��ȣȭ �� 4�ڸ��� '****'�� ��ü
SELECT 
    REPLACE(LPAD(TRIM(CUSTOMERCODE), 10, '0'),SUBSTR(LPAD(TRIM(CUSTOMERCODE), 10, '0'), 7, 4),'****') AS CSCODE,
    A.*
FROM KOPO_CUSTOMERDATA A; 







