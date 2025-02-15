WITH source AS (
    SELECT
        p.product_id,
        s.product_name,
        s.hub_department_id,
        d.department_id,  
        d.department,
        a.aisle_id,
        a.aisle,
        s.load_date
    FROM {{ ref('hub_product') }} p
    LEFT JOIN {{ ref('sat_product') }} s ON p.hub_product_id = s.hub_product_id
    LEFT JOIN {{ ref('sat_department') }} d ON s.hub_department_id = d.hub_department_id
    LEFT JOIN {{ ref('sat_aisle') }} a ON s.hub_aisle_id = a.hub_aisle_id
)
SELECT
    {{ sha256("product_id::text") }} AS dim_product_id,  
    product_id,
    product_name,
    aisle_id,
    aisle,
    department_id,
    department,
    load_date
FROM source