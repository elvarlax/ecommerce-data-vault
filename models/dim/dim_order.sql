WITH source AS (
    SELECT
        o.hub_order_id,
        s.order_id,
        s.order_number,
        s.order_dow,
        s.order_hour_of_day,
        s.days_since_prior_order,
        s.load_date
    FROM {{ ref('hub_order') }} o
    LEFT JOIN {{ ref('sat_order') }} s ON o.hub_order_id = s.hub_order_id
)
SELECT
    {{ sha256("order_id::text") }} AS dim_order_id,
    order_id,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    load_date
FROM source