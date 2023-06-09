-- UNION
-- 중복을 제거해서 조회해준다
--위 아래로 붙여버린다
--옵션이 두 개 있다는 정도 기억 (중복 제거해서 조회, 제거 안해서 조회하는 케이스)
--컬럼 갯수가 같아야 한다
-- cf) 컬럼이 다르더라도, 갯수만 같다면 합쳐서 조회한다.

-- UNION : 중복을 제거해서 조회 (시간이 더 오래걸린다)
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'MOBILE'
UNION
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'WM';

-- UNION ALL : 모두 조회 (속도가 빠르다)
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'MOBILE'
UNION ALL
SELECT *
FROM KOPO_CHANNEL_RESULT
WHERE PRODUCTGROUP = 'WM';
