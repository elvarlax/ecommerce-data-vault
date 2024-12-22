WITH source AS (
    SELECT
        op.order_id,
        op.product_id,
        op.add_to_cart_order,
        op.reordered,
        CURRENT_TIMESTAMP AS load_date,
        'order_product' AS record_source
    FROM {{ source('ecommerce', 'order_products') }} AS op
)
SELECT
    {{ sha256("order_id::text || product_id::text") }} AS link_order_product_id,
    order_id,
    product_id,
    add_to_cart_order,
    reordered,
    load_date,
    record_source
FROM source