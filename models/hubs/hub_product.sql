WITH source AS (
    SELECT
        product_id,
        product_name,
        aisle_id,
        department_id,
        CURRENT_TIMESTAMP AS load_date,
        'product' AS record_source
    FROM {{ source('ecommerce', 'products') }}
)
SELECT
    {{ sha256("product_id::text") }} AS hub_product_id,
    product_id,
    product_name,
    aisle_id,
    department_id,
    load_date,
    record_source
FROM source