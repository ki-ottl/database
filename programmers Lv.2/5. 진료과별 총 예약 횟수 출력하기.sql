APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 
이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 
예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.

SELECT *
FROM (
    SELECT MCDP_CD AS "진료과 코드", COUNT(*) AS "5월예약건수"
    FROM (
            SELECT *
            FROM APPOINTMENT
            WHERE TO_CHAR(APNT_YMD, 'YYYY-MM') = '2022-05' )
    GROUP BY MCDP_CD
    )
ORDER BY "5월예약건수" ASC, "진료과 코드" ASC