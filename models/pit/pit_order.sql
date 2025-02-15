WITH latest_order AS (
    SELECT
        hub_order_id,
        order_number,
        order_dow,
        order_hour_of_day,
        days_since_prior_order,
        load_date,
        ROW_NUMBER() OVER (PARTITION BY hub_order_id ORDER BY load_date DESC) AS row_num
    FROM {{ ref('sat_order') }}
)
SELECT
    hub_order_id,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    load_date
FROM latest_order
WHERE row_num = 1