WITH latest_order AS (
    SELECT DISTINCT ON (hub_order_id)
        hub_order_id,
        load_date
    FROM {{ ref('sat_order') }}
    ORDER BY hub_order_id, load_date DESC
)
SELECT
    hub_order_id,
    load_date
FROM latest_order