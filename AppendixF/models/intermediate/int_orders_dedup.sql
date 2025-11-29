-- Keep latest per (tenant_id, order_id)
select *
from (
  select
    tenant_id, order_id, event_dt, event_ts, amount, type, payload,
    row_number() over (partition by tenant_id, order_id order by event_ts desc) as rn
  from {{ ref('stg_orders') }}
)
where rn = 1
