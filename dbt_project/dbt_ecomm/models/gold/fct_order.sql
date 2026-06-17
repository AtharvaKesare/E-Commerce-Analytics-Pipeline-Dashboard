{{ config(materialized='table') }}

SELECT
    transaction_id,
    customer_id,
    product_id,
    order_date,
    quantity,
    price,
    quantity * price AS total_amount,
    order_status
FROM {{ ref('sl_ecommerce_sales') }}