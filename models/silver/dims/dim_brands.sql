{{ config(materialized='table') }}

SELECT
    ROW_NUMBER() OVER (ORDER BY brand) AS brand_id,
    brand AS brand_name
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE brand IS NOT NULL
GROUP BY brand
