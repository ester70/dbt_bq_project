{{ config(materialized='table') }}

SELECT
    id AS user_id,
    country,
    state,
    region
FROM `bigquery-public-data.thelook_ecommerce.users`
WHERE id IS NOT NULL
