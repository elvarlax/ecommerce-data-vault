WITH source AS (
    SELECT
        department_id,
        CURRENT_TIMESTAMP AS load_date,
        'department' AS record_source
    FROM {{ ref('stg_departments') }}
)
SELECT
    {{ sha256("department_id::text") }} AS hub_department_id,
    department_id,
    load_date,
    record_source
FROM source