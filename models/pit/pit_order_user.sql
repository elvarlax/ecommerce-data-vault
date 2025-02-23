WITH latest_order_user AS (
    SELECT DISTINCT ON (link_order_user_id)
        link_order_user_id,
        hub_order_id,
        hub_user_id,
        load_date
    FROM {{ ref('link_order_user') }}
    ORDER BY link_order_user_id, load_date DESC
)
SELECT
    link_order_user_id,
    hub_order_id,
    hub_user_id,
    load_date
FROM latest_order_user