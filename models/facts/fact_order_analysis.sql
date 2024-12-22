WITH source AS (
    SELECT 
        o.order_id,
        o.user_id,
        COUNT(op.product_id) AS product_count,
        t.order_hour_of_day
    FROM {{ ref('link_order_product') }} op
    INNER JOIN {{ ref('hub_order') }} o ON op.order_id = o.order_id
    INNER JOIN {{ ref('dim_time') }} t ON op.order_id = t.order_id
    GROUP BY o.order_id, o.user_id, t.order_hour_of_day
)
SELECT 
    order_id,
    user_id,
    product_count,
    order_hour_of_day
FROM source