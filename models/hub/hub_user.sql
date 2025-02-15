WITH source AS (
    SELECT
        user_id,
        CURRENT_TIMESTAMP AS load_date,
        'user' AS record_source
    FROM {{ ref('stg_orders') }}
)
SELECT
    {{ sha256("user_id::text") }} AS hub_user_id,
    user_id,
    load_date,
    record_source
FROM source