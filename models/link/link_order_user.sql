WITH source AS (
    SELECT
        order_id,
        user_id,
        CURRENT_TIMESTAMP AS load_date,
        'order_user' AS record_source
    FROM {{ ref('stg_orders') }}
)
SELECT
    {{ sha256("order_id::text || '|' || user_id::text") }} AS link_order_user_id,
    {{ sha256("order_id::text") }} AS hub_order_id,
    {{ sha256("user_id::text") }} AS hub_user_id,
    load_date,
    record_source
FROM source