WITH source AS (
    SELECT 
        op.product_id,
        SUM(op.add_to_cart_order) AS total_sales,
        COUNT(op.order_id) AS order_count
    FROM {{ ref('link_order_product') }} op
    GROUP BY op.product_id
)
SELECT 
    product_id,
    total_sales,
    order_count
FROM source