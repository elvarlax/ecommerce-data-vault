WITH source AS (
    SELECT 
        p.aisle_id,
        COUNT(op.order_id) AS aisle_order_count
    FROM {{ ref('link_order_product') }} op
    INNER JOIN {{ ref('dim_product') }} p ON op.product_id = p.product_id
    GROUP BY p.aisle_id
)
SELECT 
    aisle_id,
    aisle_order_count
FROM source