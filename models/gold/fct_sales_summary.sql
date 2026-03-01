{{ config(materialized='table') }}

WITH orders AS (
    SELECT
        id AS order_item_id,
        order_id,
        product_id,
        sale_price,
        created_at
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status = 'Complete' -- אנחנו רוצים רק מכירות שהושלמו
)

SELECT
    o.order_item_id,
    o.order_id,
    o.created_at,
    p.product_name,
    p.product_category, -- הנתון הזה מגיע מה-Dimension
    o.sale_price,
    p.retail_price,
    (o.sale_price - p.retail_price) AS profit -- חישוב רווח
FROM orders o
LEFT JOIN {{ ref('dim_products') }} p 
    ON o.product_id = p.product_id