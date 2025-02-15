WITH source AS (
    SELECT
        order_id::INTEGER AS order_id,
        product_id::INTEGER AS product_id,
        add_to_cart_order::INTEGER AS add_to_cart_order,
        reordered::BOOLEAN AS reordered
    FROM {{ source('ecommerce', 'order_products') }}
)
SELECT 
    order_id,
    product_id,
    add_to_cart_order,
    reordered
FROM source