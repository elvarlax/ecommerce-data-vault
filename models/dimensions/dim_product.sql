WITH source AS (
    SELECT 
        hp.product_id,
        hp.product_name,
        hp.aisle_id,
        hp.department_id,
        hp.load_date,
        hp.record_source
    FROM {{ ref('hub_product') }} hp
)
SELECT 
    product_id,
    product_name,
    aisle_id,
    department_id,
    load_date, 
    record_source
FROM source