WITH source AS (
    SELECT
        aisle_id,
        CURRENT_TIMESTAMP AS load_date,
        'aisle' AS record_source
    FROM {{ ref('stg_aisles') }}
)
SELECT
    {{ sha256("aisle_id::text") }} AS hub_aisle_id,
    aisle_id,
    load_date,
    record_source
FROM source