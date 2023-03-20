-- Expression 
-- EXPRESSION ������ ��ȸ�� �� ������ �ܿ� �߰��� �÷��� ������ �� �ִ�.
-- ���̺� ��Ī, �÷��� ��Ī�� �� �� �ִ� (AS)
-- ex. ���� ����ϴ� �ĺ��ڵ�, Ÿ���÷��� ��
-- 

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

-- �ǹ����� ���� ���
-- ����Ŭ ���� CONCAT �Լ��� �⺻������ 2���� ����
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

-- 'PREDICT_MODEL'�� �÷��̸��� MEASUREID�� ������ �� �ִ�
-- 'PREDICT_MODEL'�� ���� ù �÷����� ���� ���� ��
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

-- ���� ���� �÷��� ���� �����Բ� �ϰ�,
SELECT 'PREDICT_MODEL' AS MEASUREID, 
    A.*,  -- A ���̺��� ��� �÷�
    SYSDATE AS TIMEFLAG -- Ÿ���÷���
FROM CUSTOMERDATA A

























