WITH source AS (
    SELECT
        product_id,
        department_id,
        CURRENT_TIMESTAMP AS load_date,
        'product_department' AS record_source
    FROM {{ ref('stg_products') }}
)
SELECT
    {{ sha256("product_id::text || '|' || department_id::text") }} AS link_product_department_id,
    {{ sha256("product_id::text") }} AS hub_product_id,
    {{ sha256("department_id::text") }} AS hub_department_id,
    load_date,
    record_source
FROM source