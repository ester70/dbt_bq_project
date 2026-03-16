{{ config(materialized='table') }}

SELECT
    ROW_NUMBER() OVER (ORDER BY category, product_subcategory) AS category_id,
    category AS category_name,
    product_subcategory AS subcategory_name
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE category IS NOT NULL
GROUP BY category, product_subcategory
