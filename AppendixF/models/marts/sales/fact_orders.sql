{{ config(
    materialized='incremental',
    unique_key=['tenant_id','order_id'],
    incremental_strategy='merge'
) }}

with base as (
  select tenant_id, order_id, event_dt as d, amount
  from {{ ref('int_orders_dedup') }}
  {% if is_incremental() %}
    where d >= dateadd(day,-7,current_date())    -- small, idempotent backfill
  {% endif %}
)
select * from base;
