WITH source AS (
    SELECT
        lop.hub_order_id,
        lop.hub_product_id,  
        COUNT(*) OVER (PARTITION BY lop.hub_order_id) AS total_products_in_order,
        COUNT(*) OVER (PARTITION BY lop.hub_product_id) AS total_orders_with_product,
        CURRENT_TIMESTAMP AS load_date
    FROM {{ ref('link_order_product') }} lop
    LEFT JOIN {{ ref('sat_order_product') }} sop ON lop.hub_order_id = sop.hub_order_id AND lop.hub_product_id = sop.hub_product_id
)
SELECT
    {{ sha256("hub_order_id::text || '|' || hub_product_id::text") }} AS brg_order_product_id,
    hub_order_id,
    hub_product_id,
    total_products_in_order,
    total_orders_with_product,
    load_date
FROM source