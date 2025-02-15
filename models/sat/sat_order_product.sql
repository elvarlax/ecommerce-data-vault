WITH source AS (
    SELECT
        order_id,
        product_id,
        add_to_cart_order,
        reordered,
        CURRENT_TIMESTAMP AS load_date,
        'order_product' AS record_source
    FROM {{ ref('stg_order_products') }}
)
SELECT
    {{ sha256("order_id::text") }} AS hub_order_id,
    {{ sha256("product_id::text") }} AS hub_product_id,
    order_id,
    product_id,
    add_to_cart_order,
    reordered,
    load_date,
    record_source
FROM source