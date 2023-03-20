-- ���Ἲ ��������
-- : �̷� �� ���� ���������� �ֱ� ������ �����ͺ��̽��� �ŷ��� �� �ִ�.
-- ������ ���Ἲ ��������(�Ӽ��� ����) : ������ �÷� �Ӽ� �� �ܿ� ������� �ʴ´�.
-- ��ü ���Ἲ ��������(�⺻Ű ����) : �����̼��� �⺻Ű�� ����(NOT NULL,ONLY ONE)
-- ���� ���Ἲ ��������(�ܷ�Ű/����Ű ����)

-- 1. ������ ���Ἲ �������� : �Ӽ��� ����
-- : ������ �÷� �Ӽ� �� �ܿ� ������� �ʴ´�.
-- NUMBER �ֱ�� ������ N���� ����ֱ�

CREATE TABLE PRACTICE_TABLE_2 (
NAME VARCHAR2(100), 
BIRTH VARCHAR2(100), 
ADDRESS VARCHAR2(100) NOT NULL,
HP NUMBER;
)

-- ORA-01722: invalid number
-- NUMBER���ٰ� ���� ����־ ���� ����
INSERT INTO PRACTICE_TABLE_2
VALUES('������', '950126' , 'SEOUL' ,'�����Դϴ�');

-- ����Ŭ�� ���ڴ� ���ڵ� ���ȱ� ������ ���ڸ� �־ �ȴ�.
-- �����ӿ��� ���ڷ� �ν��ؼ� �־��ش�.
INSERT INTO PRACTICE_TABLE_2
VALUES('������', 950126 , 'SEOUL', 01011111111);

-- ORA-01400: cannot insert NULL into ("KIOTTL"."PRACTICE_TABLE_2"."ADDRESS")
-- NOT NULL �÷����ٰ� NULL�� ����־��� ������ ����
INSERT INTO PRACTICE_TABLE_2
VALUES('������2','950126', NULL, 01011111111);

--2. ��ü ���Ἲ �������� : �⺻Ű ����
-- : �����̼��� �⺻Ű�� ����(NOT NULL,ONLY ONE)
-- : �����̼��� ������ PK�� ������ �ϰ� PK�� UNIQUE & NOT NULL�̴�.
-- �⺻Ű�� �ߺ����� ���� ��쿡 ����
-- �⺻Ű�� NULL���� ��������� ����

-- ORA-00001: unique constraint (KIOTTL.PK_PRACTICE_TABLE_2) violated 
-- �⺻Ű�� �ߺ��� ����
INSERT INTO PRACTICE_TABLE_2
VALUES('������', 950126 , 'SEOUL', 01011111111);

-- ORA-01400: cannot insert NULL into ("KIOTTL"."PRACTICE_TABLE_2"."ADDRESS")
-- �⺻Ű�� NULL���� ��������� ����
INSERT INTO PRACTICE_TABLE_2
VALUES('������2','950126', NULL, 01011111111);

-- 3. ���� ���Ἲ ��������(�ܷ�Ű ����)

-- �θ����̺� ����
 CREATE TABLE KOPO_EVENT_INFO_FOREIGN(
     EVENTID VARCHAR2(20),
     EVENTPERIOD VARCHAR2(20),
     PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(EVENTID));

-- �ڽ����̺� ����
 CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
     REGIONID VARCHAR2(20),
     PRODUCTGROUP VARCHAR2(20),
     YEARWEEK VARCHAR2(8),
     VOLUME NUMBER NOT NULL,
     EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references KOPO_EVENT_INFO_FOREIGN(EVENTID) );
 
-- INSERT ����
 
-- ORA-02291: integrity constraint (KIOTTL.SYS_C007046) violated - parent key not found
-- �θ� ���̺� ���� �й����� ���� �Է� �õ�
-- EVENTID�� �ܷ�Ű�� �����Ǿ� �ֱ� ������ 
-- KOPO_EVENT_INFO_FOREIGN ���̺� ���� ���� EVENTID�� ���ؼ��� �Է��� �� �ȴ�
-- ORA-02291: integrity constraint (KIOTTL.SYS_C007046) violated - parent key not found
INSERT INTO KOPO_PRODUCT_VOLUME_FOREIGN
VALUES ('A01','SEOUL','202301', 100, 'EVENT10');

-- ORA-02292: integrity constraint (KIOTTL.SYS_C007036) violated - child record found
-- �ڽ� ���̺� ����ϰ� �ִ� �����Ͱ� �־ �θ� ���̺��� �����͸� ���� �Ұ�
DELETE 
FROM KOPO_EVENT_INFO_FOREIGN
WHERE EVENTID = 'EVENT01';

-- ���� ���̺��� ������

CREATE TABLE STUDENTLIST (
    STUDENT_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    MAJOR VARCHAR(100) NOT NULL
    constraints PK_STUDENTLIST primary key (STUDENT_ID)
);

CREATE TABLE GRADELIST (
    NUM NUMBER NOT NULL PRIMARY KEY,
    STUDENT_ID VARCHAR(100) NOT NULL,
    SUBJECT_NAME VARCHAR(100) NOT NULL,
    SCORE NUMBER NOT NULL,
    constraint PK_GRADELIST FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTLIST(STUDENT_ID)
);

INSERT INTO STUDENTLIST
VALUES ('11111111', '������1', '������а�');

INSERT INTO STUDENTLIST
VALUES ('11111122', '������2', '������а�');

INSERT INTO STUDENTLIST
VALUES ('11111133', '������3', '������а�');

SELECT * 
FROM STUDENTLIST;

INSERT INTO GRADELIST 
VALUES (1,'11111111', '�Ҽ�', 88);

INSERT INTO GRADELIST 
VALUES (2,'11111133', '���Ͼ�', 95);

INSERT INTO GRADELIST 
VALUES (3,'11111111', '��', 79);

INSERT INTO GRADELIST 
VALUES (4,'11111122', '����', 92);

SELECT *
FROM GRADELIST;

-- ���� �߻���Ű��
-- 1. ������ ���Ἲ �������� : �Ӽ��� ����
-- NUMBER�� ������ ���� ���� ������ �ȵȴ�.
-- ORA-00001: unique constraint (KIOTTL.SYS_C007045) violated
INSERT INTO GRADELIST 
VALUES (1,'11111111', '����', 100);

-- ���� �߻���Ű��
-- 1. ������ ���Ἲ �������� : �Ӽ��� ����
-- NOT NULL�� ������ ���� NULL ������ �ȵȴ�.
-- ORA-01400: cannot insert NULL into ("KIOTTL"."GRADELIST"."NUM")
INSERT INTO GRADELIST 
VALUES (NULL,NULL, NULL, NULL);

-- ���� �߻���Ű��
-- 2. ��ü ���Ἲ �������� : �⺻Ű ����
-- ���̺��� ������ PK�� ������ �ϰ�, PK�� UNIQUE&NULL�̴�.
-- �⺻Ű�� �ߺ��� �������� �õ�
-- ORA-00001: unique constraint (KIOTTL.SYS_C007045) violated
INSERT INTO GRADELIST
VALUES (1,'11111111', '����', 100);

-- ���� �߻���Ű��
-- 2. ��ü ���Ἲ �������� : �⺻Ű ����
-- ���̺��� ������ PK�� ������ �ϰ�, PK�� UNIQUE&NULL�̴�.
-- �⺻Ű�� NULL �� �������� �õ�
-- ORA-01400: cannot insert NULL into ("KIOTTL"."GRADELIST"."NUM")
INSERT INTO GRADELIST
VALUES (NULL,'11111111', '����', 100);

-- ���� �߻���Ű��
-- 3. ���� ���Ἲ �������� : �ܷ�Ű ����
-- �θ� ���̺� ���� �й����� ���� �Է� �õ�
-- STUDENT_ID�� �ܷ�Ű�� �����Ǿ� �ֱ� ������ 
-- STUDENT_LIST ���̺� ���� �й��� ���ؼ��� �Է��� �� �ȴ�
-- ORA-02291: integrity constraint (KIOTTL.SYS_C007046) violated - parent key not found
INSERT INTO GRADELIST
VALUES (5, '11111177', '�����а���', 85);

-- ���� �߻���Ű��
-- 3. ���� ���Ἲ �������� : �ܷ�Ű ����
-- NULL���� ���� ���. ���� �Ұ����� ��쿡�� ����� 
-- �ڽ��� �θ� �����ϴ� ���, �θ��� �⺻Ű�� �ڽĿ��� �ܷ�Ű�� ���ȴ�.
-- �ڽ� ���̺� ����ϰ� �ִ� �����Ͱ� �־ �θ� ���̺��� �����͸� ���� �Ұ�
-- ORA-02292: integrity constraint (KIOTTL.SYS_C007036) violated - child record found
DELETE 
FROM STUDENTLIST
WHERE STUDENT_ID = '11111111';

SELECT * 
FROM STUDENTLIST;

SELECT *
FROM GRADELIST;

-- ON DELETE CASCADE : �θ� ���̺��� ���� ������ �ڽ� ���̺� �ش� �� ��ü�� ������
-- ON DELETE SET NULL : �θ� ���̺��� ���� ������ �ڽ� ���̺� �� NULL ó��
