WITH source AS (
    SELECT 
        lpd.department_id,
        SUM(CASE WHEN op.reordered = 1 THEN 1 ELSE 0 END) AS reorder_count,
        COUNT(op.product_id) AS total_products
    FROM {{ ref('link_product_department') }} lpd
    INNER JOIN {{ ref('link_order_product') }} op ON lpd.product_id = op.product_id
    GROUP BY lpd.department_id
)
SELECT 
    department_id,
    reorder_count,
    total_products,
    reorder_count / total_products AS reorder_rate
FROM source