WITH pre_aggregated AS (
    SELECT
        fact.hub_product_id,
        SUM(fact.reordered::int) AS total_reorders,
        COUNT(fact.hub_order_id) AS total_orders
    FROM {{ ref('fact_product_sales') }} fact
    GROUP BY fact.hub_product_id
)
SELECT
    hub_product_id AS dim_product_id,
    total_reorders,
    total_orders,
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_reorders::float / total_orders 
    END AS reorder_rate
FROM pre_aggregated