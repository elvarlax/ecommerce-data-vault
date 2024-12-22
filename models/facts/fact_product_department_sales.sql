WITH source AS (
    SELECT 
        lpd.product_id,
        lpd.department_id,
        SUM(op.add_to_cart_order) AS total_sales
    FROM {{ ref('link_product_department') }} lpd
    INNER JOIN {{ ref('link_order_product') }} op ON lpd.product_id = op.product_id
    GROUP BY lpd.product_id, lpd.department_id
)
SELECT 
    product_id,
    department_id,
    total_sales
FROM source