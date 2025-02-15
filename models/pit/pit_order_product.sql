WITH latest_order_product AS (
    SELECT
        link_order_product_id,
        hub_order_id,
        hub_product_id,
        load_date,
        ROW_NUMBER() OVER (PARTITION BY link_order_product_id ORDER BY load_date DESC) AS row_num
    FROM {{ ref('link_order_product') }}
)
SELECT
    link_order_product_id,
    hub_order_id,
    hub_product_id,
    load_date
FROM latest_order_product
WHERE row_num = 1