-- ���̺�(�����̼�)
-- ��� �÷�(��)�� �ִ� ������
-- RDB(Relational DataBase)��� �θ���

-- ���� �۾�
MYDB2 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  ) 
  
-- ����� ����
--CREATE USER ����ڸ�
--IDENTIFIED BY ��й�ȣ
CREATE USER KIOTTL
IDENTIFIED BY KIOTTL;

-- ��������� ������ �ش�  
-- CONNECT(����), RESOURCE(�ڿ�), DBA(��ü����)
GRANT CONNECT, RESOURCE, DBA TO KIOTTL;

-- �̷��� �ϰ� �� �������� SELECT * FROM TABS; �ϸ� ������ ����
-- ����Ŭ ��� ���� ���̹Ƿ� �����ؼ� �ȵ�!
-- ���� �ڽŸ��� ������ �ʿ��ϴ�!
-- MYDB2�� ID�� PW�� �����ؼ� ��������!

-- ������ ����� ���� Ȯ��
SELECT *
FROM DBA_USERS

-- ����� ��й�ȣ ����
ALTER USER {����ڸ�}
IDENTIFIED BY {��й�ȣ}

-- ����� ����
DROP USER {����ڸ�} CASCADE;

--�����ͺ��̽� ���� ����
--Ÿ�� �����ͺ��̽��� ������ ��
--1. �������� ���, 2. ��ȭ�� ����, 3. �������� ������ �ؾ��Ѵ�!
--�������� ����� TNSnamesEditor
--��ȭ�� ������ �Ʒ��� �����ϰ�,
--�������� ������ Toad�� SQL NET Editor

--Ÿ���� Database�� �����غ���
--IP, PORT, DATABASE NAME, USER NAME, PASSWORD
--�޾Ƽ� �Ȱ��� TNSnamesEditor���� �������� ����� ���ش�.
--�������� ����, ��ȭ�� ������ �����ؾ� �ϱ� ������ �ȵ� ���̴�.

--��ȭ�� ����
--��� ������ ���Ե� Windows Defender ��ȭ��
---> �ιٿ�� ��Ģ (������ ��Ģ�� �����ϰڴ�)
---> �� ��Ģ
---> ��Ʈ
---> Ư�� ������Ʈ�� 1521 ���� (1521�� �����ϴ� ���� �����ְڴ�<-�� ����)
---(cf. 1521, 3306, 5432�� �ǹ����� ���� ���� ���Ǵ� ���ѻ�)
---> (����) �̸� : �����ͺ��̽� ���� ��Ʈ / ���� : ����Ŭ 1521








  