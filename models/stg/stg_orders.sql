WITH source AS (
    SELECT
        order_id::INTEGER AS order_id,
        user_id::INTEGER AS user_id,
        order_number::INTEGER AS order_number,
        order_dow::INTEGER AS order_dow,
        order_hour_of_day::INTEGER AS order_hour_of_day,
        COALESCE(days_since_prior_order, 0)::INTEGER AS days_since_prior_order
    FROM {{ source('ecommerce', 'orders') }}
)
SELECT 
    order_id,
    user_id,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order
FROM source