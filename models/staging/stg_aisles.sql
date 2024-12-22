WITH source AS (
    SELECT
        aisle_id,
        aisle
    FROM {{ source('ecommerce', 'aisles') }}
)
SELECT
    aisle_id,
    aisle
FROM source