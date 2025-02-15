WITH source AS (
    SELECT
        order_dow,
        order_hour_of_day,
        COUNT(order_id) AS total_orders
    FROM {{ ref('dim_order') }}
    GROUP BY order_dow, order_hour_of_day
)
SELECT
    order_dow,
    order_hour_of_day,
    total_orders
FROM source