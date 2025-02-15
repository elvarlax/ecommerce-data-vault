WITH source AS (
    SELECT
        s.order_id,
        s.user_id,
        s.order_number,
        s.order_dow,
        s.order_hour_of_day,
        s.days_since_prior_order,
        s.load_date
    FROM {{ ref('sat_order') }} s
    LEFT JOIN {{ ref('hub_order') }} o ON s.hub_order_id = o.hub_order_id
)
SELECT
    {{ sha256("order_id::text") }} AS fact_order_id,
    {{ sha256("user_id::text") }} AS dim_user_id,
    order_id,
    user_id,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    load_date
FROM source