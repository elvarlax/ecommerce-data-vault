WITH source AS (
    SELECT DISTINCT
        user_id,
        load_date
    FROM {{ ref('hub_user') }}
)
SELECT
    {{ sha256("user_id::text") }} AS dim_user_id,
    user_id,
    load_date
FROM source