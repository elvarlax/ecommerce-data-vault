WITH latest_product AS (
    SELECT DISTINCT ON (hub_product_id)
        hub_product_id,
        hub_aisle_id,
        hub_department_id,
        load_date
    FROM {{ ref('sat_product') }}
    ORDER BY hub_product_id, load_date DESC
),
latest_aisle AS (
    SELECT DISTINCT ON (hub_aisle_id)
        hub_aisle_id,
        load_date
    FROM {{ ref('sat_aisle') }}
    ORDER BY hub_aisle_id, load_date DESC
),
latest_department AS (
    SELECT DISTINCT ON (hub_department_id)
        hub_department_id,
        load_date
    FROM {{ ref('sat_department') }}
    ORDER BY hub_department_id, load_date DESC
)
SELECT
    p.hub_product_id,
    p.hub_aisle_id,
    p.hub_department_id,
    p.load_date
FROM latest_product p
LEFT JOIN latest_aisle a ON p.hub_aisle_id = a.hub_aisle_id
LEFT JOIN latest_department d ON p.hub_department_id = d.hub_department_id