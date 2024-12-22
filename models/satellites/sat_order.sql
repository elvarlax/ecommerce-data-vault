WITH source AS (
    SELECT
        order_id,
        user_id,
        order_number,
        order_dow,
        order_hour_of_day,
        days_since_prior_order,
        CURRENT_TIMESTAMP AS load_date,
        'order' AS record_source
    FROM {{ source('ecommerce', 'orders') }}
)
SELECT
    {{ sha256("order_id::text") }} AS satellite_order_id,
    order_id,
    user_id,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    load_date,
    record_source
FROM source