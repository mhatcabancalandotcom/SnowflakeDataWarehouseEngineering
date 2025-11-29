-- Grain: one row per event
with src as (
  select
    to_timestamp_ntz(value:ts)           as event_ts,
    to_date(value:ts)                    as event_dt,      -- envelope
    value:tenant_id::string             as tenant_id,     -- envelope
    value:order_id::string              as order_id,
    try_to_number(value:amount)         as amount,
    value:type::string                  as type,
    value                               as payload
  from {{ source('raw','orders_json') }},
       lateral flatten(input => raw.orders_json.payload)
)
select * from src
where event_dt >= dateadd(day,-30,current_date());
