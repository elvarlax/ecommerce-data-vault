WITH source AS (
    SELECT 
        hd.department_id,
        hd.department,
        hd.load_date,
        hd.record_source
    FROM {{ ref('hub_department') }} hd
)
SELECT 
    department_id,
    department,
    load_date,
    record_source
FROM source