-- UNION
-- �ߺ��� �����ؼ� ��ȸ���ش�
--�� �Ʒ��� �ٿ�������
--�ɼ��� �� �� �ִٴ� ���� ��� (�ߺ� �����ؼ� ��ȸ, ���� ���ؼ� ��ȸ�ϴ� ���̽�)
--�÷� ������ ���ƾ� �Ѵ�

-- UNION : �ߺ��� �����ؼ� ��ȸ (�ð��� �� �����ɸ���)
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'MOBILE'
UNION
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'WM';

-- UNION ALL : ��� ��ȸ (�ӵ��� ������)
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'MOBILE'
UNION ALL
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'WM';



























