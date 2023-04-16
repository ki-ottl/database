-- �ܷ�Ű (Foreign Key)
-- : �ٸ� �����̼�(���̺�)�� �⺻Ű�� �����ϴ� �Ӽ� (�ٸ� ���̺��� �⺻Ű�� ���ܿ��� ��)

-- �ܷ�Ű�� ���̺��� �� �� ���� �� �ش�ȴ�.
-- �ܷ�Ű�� ���Ǵ� �ٸ� ���̺��� �⺻Ű�� ���ܿ��� ��.
-- ���� Ÿ ���̺��� �⺻Ű�� ��ܿ��� �ʴ´ٸ�, �ߺ��� ���� ���� ȥ���� ���� �� �ִ�.
-- ex) ����ȣ�� EV01�ε� �ϳ��� ��縦 30%�Ѵٰ� �ϰ�, �ϳ��� 50% �Ѵٰ� �ϸ�..?

-- �ܷ�Ű ���� ���
CREATE TABLE KOPO_PRODUCT_VOLUME(
�÷���1 Ÿ��(����),
��
constraints [fk��] foreign key (�÷���) references �⺻Ű�������̺��(�ش����̺� �⺻Ű) )

-- constraints : ���������� �ְڴ�
-- references : �����ϰڴ�.

 CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
     REGIONID VARCHAR2(20),
     PRODUCTGROUP VARCHAR2(20),
     YEARWEEK VARCHAR2(8),
     VOLUME NUMBER NOT NULL,
     EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references KOPO_EVENT_INFO_FOREIGN(EVENTID) );
 
--constraints : ���������� �ְڴ�
--fk_kopo_product_volume_foreign : FK �̸�
--eventid : �ܷ�Ű�� ������ �÷���
--references : �����ϰڴ�
--KOPO_EVENT_INFO_FOREIGN(EVENTID) : KOPO_EVENT_INFO_FOREIGN ���̺��� EVENTID��

