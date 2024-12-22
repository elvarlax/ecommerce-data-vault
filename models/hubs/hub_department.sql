WITH source AS (
    SELECT
        department_id,
        department,
        CURRENT_TIMESTAMP AS load_date,
        'department' AS record_source
    FROM {{ source('ecommerce', 'departments') }}
)
SELECT
    {{ sha256("department_id::text") }} AS hub_department_id,
    department_id,
    department,
    load_date,
    record_source
FROM source