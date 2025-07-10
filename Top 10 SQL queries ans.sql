--Answers to top 10 SQL queries:
--1. delete duplicate data

WITH DUPLICATES AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY PARTITION BY model_name, color, brand
      ORDER BY model_id) AS RN
FROM CARS
)
DELETE FROM CARS 
WHERE MODEL_ID IN (
                   SELECT MODEL_ID FROM DUPLICATES 
                   WHERE RN>1);

--2.Highest and Lowest salary


WITH HIGH_SAL AS (
  SELECT *,
         DENSE_RANK() OVER (
           PARTITION BY dept 
           ORDER BY salary DESC
         ) AS dn1
  FROM employee
),
LOW_SAL AS (
  SELECT *,
         DENSE_RANK() OVER (
           PARTITION BY dept 
           ORDER BY salary ASC
         ) AS dn2
  FROM employee
)
SELECT * FROM HIGH_SAL WHERE dn1 = 1
UNION
SELECT * FROM LOW_SAL WHERE dn2 = 1;

