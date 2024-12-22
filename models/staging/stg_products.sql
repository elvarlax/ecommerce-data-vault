WITH source AS (
    SELECT
        product_id,
        product_name,
        aisle_id,
        department_id
    FROM {{ source('ecommerce', 'products') }}
)
SELECT
    product_id,
    product_name,
    aisle_id,
    department_id
FROM source