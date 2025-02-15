WITH source AS (
    SELECT
        order_id,
        CURRENT_TIMESTAMP AS load_date,
        'order' AS record_source
    FROM {{ ref('stg_orders') }}
)
SELECT
    {{ sha256("order_id::text") }} AS hub_order_id,
    order_id,
    load_date,
    record_source
FROM source