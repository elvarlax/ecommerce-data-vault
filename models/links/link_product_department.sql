WITH source AS (
    SELECT
        p.product_id,
        p.department_id,
        CURRENT_TIMESTAMP AS load_date,
        'product_department' AS record_source
    FROM {{ source('ecommerce', 'products') }} AS p
)
SELECT
    {{ sha256("product_id::text || department_id::text") }} AS link_product_department_id,
    product_id,
    department_id,
    load_date,
    record_source
FROM source