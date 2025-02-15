WITH source AS (
    SELECT
        order_id,
        product_id,
        CURRENT_TIMESTAMP AS load_date,
        'order_product' AS record_source
    FROM {{ ref('stg_order_products') }}
)
SELECT
    {{ sha256("order_id::text || '|' || product_id::text") }} AS link_order_product_id,
    {{ sha256("order_id::text") }} AS hub_order_id,
    {{ sha256("product_id::text") }} AS hub_product_id,
    load_date,
    record_source
FROM source