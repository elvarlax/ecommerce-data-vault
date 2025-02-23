WITH aggregated_counts AS (
    SELECT 
        hub_order_id,
        hub_product_id,
        COUNT(*) AS total_products_in_order,
        COUNT(*) OVER (PARTITION BY hub_product_id) AS total_orders_with_product,
        MAX(load_date) AS load_date
    FROM {{ ref('link_order_product') }}
    GROUP BY hub_order_id, hub_product_id
)
SELECT 
    {{ sha256("hub_order_id::text || '|' || hub_product_id::text") }} AS brg_order_product_id,
    hub_order_id,
    hub_product_id,
    total_products_in_order,
    total_orders_with_product,
    load_date
FROM aggregated_counts