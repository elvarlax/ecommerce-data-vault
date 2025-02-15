WITH source AS (
    SELECT
        aisle_id::INTEGER AS aisle_id,
        aisle::TEXT AS aisle
    FROM {{ source('ecommerce', 'aisles') }}
)
SELECT 
    aisle_id,
    aisle
FROM source