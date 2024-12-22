WITH source AS (
    SELECT 
        ha.aisle_id,
        ha.aisle,
        ha.load_date,
        ha.record_source
    FROM {{ ref('hub_aisle') }} ha
)
SELECT 
    aisle_id,
    aisle,
    load_date,
    record_source
FROM source