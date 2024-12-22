WITH source AS (
    SELECT 
        o.user_id,
        COUNT(o.order_id) AS order_count,
        t.order_dow
    FROM {{ ref('hub_order') }} o
    INNER JOIN {{ ref('dim_time') }} t ON o.order_id = t.order_id
    GROUP BY o.user_id, t.order_dow
)
SELECT 
    user_id, 
    order_count, 
    order_dow
FROM source