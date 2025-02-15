WITH latest_order_user AS (
    SELECT
        link_order_user_id,
        hub_order_id,
        hub_user_id,
        load_date,
        ROW_NUMBER() OVER (PARTITION BY link_order_user_id ORDER BY load_date DESC) AS row_num
    FROM {{ ref('link_order_user') }}
)
SELECT
    link_order_user_id,
    hub_order_id,
    hub_user_id,
    load_date
FROM latest_order_user
WHERE row_num = 1