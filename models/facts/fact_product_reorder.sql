WITH source AS (
    SELECT 
        op.product_id,
        COUNT(op.reordered) AS reorder_count
    FROM {{ ref('link_order_product') }} op
    WHERE op.reordered = 1
    GROUP BY op.product_id
)
SELECT 
    product_id,
    reorder_count
FROM source