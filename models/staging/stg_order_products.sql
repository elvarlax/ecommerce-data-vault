WITH source AS (
    SELECT
        order_id,
        product_id,
        add_to_cart_order,
        reordered
    FROM {{ source('ecommerce', 'order_products') }}
)
SELECT
    order_id,
    product_id,
    add_to_cart_order,
    reordered
FROM source