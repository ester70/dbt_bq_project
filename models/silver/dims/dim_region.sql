{{ config(materialized='table') }}

SELECT
    ROW_NUMBER() OVER (ORDER BY region) AS region_id,
    region AS region_name
FROM `bigquery-public-data.thelook_ecommerce.users`
WHERE region IS NOT NULL
GROUP BY region
