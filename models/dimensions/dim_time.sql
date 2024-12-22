WITH source AS (
    SELECT 
        o.order_id,
        o.order_hour_of_day,
        o.order_dow,
        CASE 
            WHEN o.order_hour_of_day < 12 THEN 'AM'
            ELSE 'PM'
        END AS order_time_of_day
    FROM {{ ref('sat_order') }} o
)
SELECT 
    order_id,
    order_hour_of_day,
    order_dow,
    order_time_of_day
FROM source