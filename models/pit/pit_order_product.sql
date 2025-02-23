WITH latest_order_product AS (
    SELECT DISTINCT ON (link_order_product_id)
        link_order_product_id,
        hub_order_id,
        hub_product_id,
        load_date
    FROM {{ ref('link_order_product') }}
    ORDER BY link_order_product_id, load_date DESC
)
SELECT
    link_order_product_id,
    hub_order_id,
    hub_product_id,
    load_date
FROM latest_order_product