WITH source AS (
    SELECT
        order_id,
        user_id,
        order_number,
        order_dow,
        order_hour_of_day,
        days_since_prior_order,
        CURRENT_TIMESTAMP AS load_date,
        'orders' AS record_source
    FROM {{ ref('stg_orders') }}  
)
SELECT
    {{ sha256("order_id::text") }} AS hub_order_id,  
    order_id,
    user_id,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    load_date,
    record_source
FROM source