-- models/silver/orders.sql
{{ config(materialized='incremental', unique_key='order_id') }}

SELECT
  order_id,
  customer_id,
  total,
  order_ts
FROM {{ ref('stage_orders_norm') }}
{% if is_incremental() %}
WHERE order_ts > (SELECT COALESCE(MAX(order_ts), '1900-01-01') FROM {{ this }})
{% endif %}
