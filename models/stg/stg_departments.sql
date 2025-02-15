WITH source AS (
    SELECT
        department_id::INTEGER AS department_id,
        department::TEXT AS department
    FROM {{ source('ecommerce', 'departments') }}
)
SELECT 
    department_id,
    department
FROM source