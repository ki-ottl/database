-- DB LINK 
-- ����DB�� �ִ� ������ �DB�� �̰��ϴ� ��!
-- DB LINK�� DB �������� ���� ������ ����!
-- DB LINK�� �ɾ�θ� ����Ʈ ���� �ϳ��� Ÿ PC�� �����͸� ���ܿ� �� �ִ�

-- �б� ������ ���̺��� ����ͼ� ���� 
CREATE DATABASE LINK KOPOSERVER2
CONNECT TO kopo
IDENTIFIED BY kopo
Using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.110.112)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';

--DB LINK Ȯ��
SELECT * 
FROM ALL_DB_LINKS;

-- �������� DB ������ ��� ���̺��� ��ȸ
SELECT *
FROM TABS@KOPOSERVER2;

-- �������� DB ������ Ư�� ���̺��� ��ȸ
SELECT *
FROM PRO_PROMOTION@KOPOSERVER2;

-- �������� DB ������ �ִ� ���̺��� �� ������ ����
CREATE TABLE PRO_PROMOTION
AS
SELECT *
FROM PRO_PROMOTION@KOPOSERVER2;

-- �� ������ KOPOSERVER2�� PRO_PROMOTION ���̺� Ȯ��
SELECT *
FROM TABS;

-- DB LINK ����
DROP TABLE PRO_PROMOTION






























