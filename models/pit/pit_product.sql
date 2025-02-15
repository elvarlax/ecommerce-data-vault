WITH latest_product AS (
    SELECT
        hub_product_id,
        product_name,
        hub_aisle_id,
        hub_department_id,
        load_date,
        ROW_NUMBER() OVER (PARTITION BY hub_product_id ORDER BY load_date DESC) AS row_num
    FROM {{ ref('sat_product') }}
),
latest_aisle AS (
    SELECT
        hub_aisle_id,
        aisle,
        load_date,
        ROW_NUMBER() OVER (PARTITION BY hub_aisle_id ORDER BY load_date DESC) AS row_num
    FROM {{ ref('sat_aisle') }}
),
latest_department AS (
    SELECT
        hub_department_id,
        department,
        load_date,
        ROW_NUMBER() OVER (PARTITION BY hub_department_id ORDER BY load_date DESC) AS row_num
    FROM {{ ref('sat_department') }}
)
SELECT
    p.hub_product_id,
    p.product_name,
    a.aisle,
    d.department,
    p.load_date
FROM latest_product p
LEFT JOIN latest_aisle a ON p.hub_aisle_id = a.hub_aisle_id AND a.row_num = 1
LEFT JOIN latest_department d ON p.hub_department_id = d.hub_department_id AND d.row_num = 1
WHERE p.row_num = 1