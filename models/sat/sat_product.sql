WITH source AS (
    SELECT
        product_id,
        aisle_id,
        department_id,
        product_name,
        CURRENT_TIMESTAMP AS load_date,
        'product' AS record_source
    FROM {{ ref('stg_products') }}
)
SELECT
    {{ sha256("product_id::text") }} AS hub_product_id,
    product_name,  
    {{ sha256("aisle_id::text") }} AS hub_aisle_id,  
    {{ sha256("department_id::text") }} AS hub_department_id,
    load_date,
    record_source
FROM source