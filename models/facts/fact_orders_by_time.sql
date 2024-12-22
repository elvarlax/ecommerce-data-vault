WITH source AS (
    SELECT 
        t.order_hour_of_day,
        t.order_dow,
        COUNT(o.order_id) AS order_count
    FROM {{ ref('hub_order') }} o
    INNER JOIN {{ ref('dim_time') }} t ON o.order_id = t.order_id
    GROUP BY t.order_hour_of_day, t.order_dow
)
SELECT 
    order_hour_of_day,
    order_dow, 
    order_count
FROM source