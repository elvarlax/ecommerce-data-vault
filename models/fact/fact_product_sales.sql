WITH source AS (
    SELECT
        bop.hub_product_id,
        bop.hub_order_id,
        p.product_name,
        bop.total_orders_with_product,
        s.reordered,
        s.load_date
    FROM {{ ref('brg_order_product') }} bop
    LEFT JOIN {{ ref('sat_product') }} p ON bop.hub_product_id = p.hub_product_id
    LEFT JOIN {{ ref('sat_order_product') }} s ON bop.hub_product_id = s.hub_product_id
)
SELECT
    hub_product_id,
    hub_order_id,
    product_name,
    total_orders_with_product,
    reordered,
    load_date
FROM source