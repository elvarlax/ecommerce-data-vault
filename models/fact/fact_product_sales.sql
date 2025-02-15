WITH pre_filtered AS (
    SELECT
        bop.hub_product_id,
        bop.hub_order_id,
        bop.total_orders_with_product,
        s.reordered,
        s.load_date
    FROM {{ ref('brg_order_product') }} bop
    LEFT JOIN {{ ref('sat_order_product') }} s ON bop.hub_product_id = s.hub_product_id AND bop.hub_order_id = s.hub_order_id
), 
deduplicated AS (
    SELECT DISTINCT ON (hub_product_id, hub_order_id)
        hub_product_id,
        hub_order_id,
        total_orders_with_product,
        reordered,
        load_date
    FROM pre_filtered
    ORDER BY hub_product_id, hub_order_id, load_date DESC
)
SELECT
    d.hub_product_id,
    d.hub_order_id,
    p.product_name,
    d.total_orders_with_product,
    d.reordered,
    d.load_date
FROM deduplicated d
LEFT JOIN {{ ref('sat_product') }} p ON d.hub_product_id = p.hub_product_id