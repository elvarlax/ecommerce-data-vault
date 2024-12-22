WITH source AS (
    SELECT
        order_id,
        user_id,
        CURRENT_TIMESTAMP AS load_date,
        'order' AS record_source
    FROM {{ source('ecommerce', 'orders') }}
)
SELECT
    {{ sha256("order_id::text") }} AS hub_order_id,
    order_id,
    user_id,
    load_date,
    record_source
FROM source