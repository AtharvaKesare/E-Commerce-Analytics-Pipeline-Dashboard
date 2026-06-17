{{ config(materialized='table') }}

WITH product_ranked AS (

    SELECT
        product_id,
        product_category,
        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY product_category
        ) AS rn
    FROM {{ ref('sl_ecommerce_sales') }}

)

SELECT
    product_id,
    product_category
FROM product_ranked
WHERE rn = 1