CREATE TABLE STUDENTLIST (
    STUDENT_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    MAJOR VARCHAR(100) NOT NULL
);

CREATE TABLE GRADELIST (
    NUM NUMBER NOT NULL PRIMARY KEY,
    STUDENT_ID VARCHAR(100) NOT NULL,
    SUBJECT_NAME VARCHAR(100) NOT NULL,
    SCORE NUMBER NOT NULL,
    FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTLIST(STUDENT_ID)
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

--��Ģ
--�ڽ�(���̺�)�� �θ�(���̺�) ���� ����� ��������.
--�ڽ�(���̺�)�� drop, delete �����ʰ� �θ�(���̺�)�� ���� �� �� ����.
--�θ�(���̺�)�� �����Ͱ� ������ �ڽ�(���̺�)�� �����͸� ������ ����.