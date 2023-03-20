-- �⺻Ű (Primary Key)
-- : ���̺� ������ �ϳ��� �����Ͽ� ��ǥ�� ��� Ű

-- 1. �ĺ��� �� �ִ� ������ ���� ������ �Ѵ�.
-- �ߺ��� ������� �ʴ´�.
-- ex)����, ī���, ������ �⺻Ű ������ �Ǿ����� ��쿡
-- (��������, �ϳ�ī��, 202301, 100)
-- (��������, �ϳ�ī��, 202301, 200) -> �Ұ�
-- �������� �ŷڼ��� �ǹ��� ����� ������
-- 1������ 100�� �Ǹ����� 200 �Ǹ����� ȥ���� �� �� �ִ�.
-- ���������� ���̺��� �޾��� �� ���� ���� �⺻Ű�� �������� �ľ��ؼ�
-- ����, ��ǰ, �������� �ŷ����� �����ߴٴ� ���� �ؼ��ؾ��Ѵ�.

--- �⺻ Ű �����̸Ӹ� Ű ����
CREATE TABLE KOPO_PRODUCT_VOLUME(
    REGIONID VARCHAR2(100),
    PRODUCT VARCHAR2(100),
    YEARWEEK VARCHAR2(100),
    QTY NUMBER,
    constraints PK_KOPO_PRODUCT_VOLUME primary key (REGIONID, PRODUCT,YEARWEEK);
)

-- constraints : ���������� �ְڴ�
-- PK_KOPO_PRODUCT_VOLUME : PK �̸� (���߿� PK���� �˻��� ���� ���� �� ����)
-- REGIONID, PRODUCT,YEARWEEK : �⺻Ű�� ������ �÷�

 CREATE TABLE KOPO_EVENT_INFO_FOREIGN(
     EVENTID VARCHAR2(20),
     EVENTPERIOD VARCHAR2(20),
     PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(EVENTID));
 
-- constraints : ���������� �ְڴ�
-- pk_kopo_event_info_foreign : PK �̸� (���߿� PK���� �˻��� ���� ���� �� ����)
-- EVENTID : �⺻Ű�� ������ �÷�
-- cf) PK : �⺻Ű ���� PK���̺������ �����ϸ� �ߺ��� ���� ����(���̺���� �ߺ��� �ȵǱ� ������)

INSERT INTO KOPO_PRODUCT_VOLUME
VALUES ('A01', 'PRODUCT01', '202301', 100);

-- ���� �����͸� �� �� �����ϸ� ������ ���.
-- ORA-00001: unique constraint(KIOTTL.PK_KOPO_PRODUCT_VOLUME)
-- �⺻Ű�� ����Ǿ��ٴ� ����. (�ߺ����� ������� �ʱ� ����)

-- 2. NULL ���� ������� �ʴ´�.


--�⺻Ű���� NULL�� �� �� ����.
-- ORA-01400: cannot insert NULL into ("KIOTTL"."PK_KOPO_PRODUCT_VOLUME"."REGIONID")
INSERT INTO KOPO_PRODUCT_VOLUME
VALUES (NULL, 'PRODUCT01', '202301', 100);

-- cf) �⺻Ű ��ȸ ��� (�ϱ� ���ʿ�)
SELECT * FROM
ALL CONSTRAINTS
WHERE 1=1
AND TABLE_NAME = 'KOPO_PRODUCT_VOLUME'