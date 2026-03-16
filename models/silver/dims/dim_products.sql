{{ config(materialized='table') }}

SELECT
    id AS product_id,
    name AS product_name,
    category AS product_category,
    product_subcategory AS product_subcategory,
    brand,
    department,
    retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE id IS NOT NULL
