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
