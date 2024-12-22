WITH source AS (
    SELECT 
        o.user_id,
        o.order_id,
        COUNT(op.product_id) AS product_count
    FROM {{ ref('link_order_product') }} op
    INNER JOIN {{ ref('hub_order') }} o ON op.order_id = o.order_id
    GROUP BY o.user_id, o.order_id
)
SELECT 
    user_id, 
    order_id,
    product_count
FROM source