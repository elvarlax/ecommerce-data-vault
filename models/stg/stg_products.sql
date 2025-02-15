WITH source AS (
    SELECT
        product_id::INTEGER AS product_id,
        aisle_id::INTEGER AS aisle_id,
        department_id::INTEGER AS department_id,
        product_name::TEXT AS product_name
    FROM {{ source('ecommerce', 'products') }}
)
SELECT 
    product_id,
    aisle_id,
    department_id,
    product_name
FROM source