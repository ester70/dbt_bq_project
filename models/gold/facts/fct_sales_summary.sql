{{ config(materialized='table') }}

WITH order_items_complete AS (
    SELECT
        id AS order_item_id,
        order_id,
        product_id,
        sale_price,
        created_at
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status = 'Complete'
),
orders AS (
    SELECT
        id AS order_id,
        user_id
    FROM `bigquery-public-data.thelook_ecommerce.orders`
)

SELECT
    oi.order_item_id,
    oi.order_id,
    ord.user_id,
    u.region,
    oi.created_at,
    oi.product_id,
    p.product_name,
    p.product_category,
    p.brand,
    p.department,
    oi.sale_price,
    p.retail_price,
    (oi.sale_price - p.retail_price) AS profit
FROM order_items_complete oi
LEFT JOIN orders ord ON oi.order_id = ord.order_id
LEFT JOIN {{ ref('dim_users') }} u ON ord.user_id = u.user_id
LEFT JOIN {{ ref('dim_products') }} p ON oi.product_id = p.product_id
