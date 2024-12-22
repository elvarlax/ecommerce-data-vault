WITH source AS (
    SELECT 
        o.order_id,
        o.user_id,
        p.product_id,
        t.order_hour_of_day,
        t.order_dow
    FROM {{ ref('link_order_product') }} op
    INNER JOIN {{ ref('hub_order') }} o ON op.order_id = o.order_id
    INNER JOIN {{ ref('dim_product') }} p ON op.product_id = p.product_id
    INNER JOIN {{ ref('dim_time') }} t ON op.order_id = t.order_id
)
SELECT 
    order_id,
    user_id,
    product_id,
    order_hour_of_day,
    order_dow
FROM source