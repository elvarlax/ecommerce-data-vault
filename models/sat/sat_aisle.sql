WITH source AS (
    SELECT
        aisle_id,
        aisle,
        CURRENT_TIMESTAMP AS load_date,
        'aisle' AS record_source
    FROM {{ ref('stg_aisles') }}
)
SELECT
    {{ sha256("aisle_id::text") }} AS hub_aisle_id,
    aisle_id,
    aisle,
    load_date,
    record_source
FROM source