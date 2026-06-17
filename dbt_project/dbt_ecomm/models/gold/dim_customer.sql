{{ config(materialized='table') }}

WITH customer_ranked AS (

    SELECT
        customer_id,
        customer_name,
        country,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY customer_name
        ) AS rn
    FROM {{ ref('sl_ecommerce_sales') }}

)

SELECT
    customer_id,
    customer_name,
    country
FROM customer_ranked
WHERE rn = 1