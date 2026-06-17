{{ config(materalized='view')}}

SELECT *
FROM {{ ref('ecommerce_sales')}}