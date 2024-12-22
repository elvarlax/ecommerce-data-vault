WITH source AS (
    SELECT
        department_id,
        department
    FROM {{ source('ecommerce', 'departments') }}
)
SELECT
    department_id,
    department
FROM source