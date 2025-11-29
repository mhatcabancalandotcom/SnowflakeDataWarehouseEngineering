SELECT
  e.tenant,
  e.payload:order_id::STRING AS order_id,
  f.value:sku::STRING        AS sku,
  f.value:qty::NUMBER        AS qty
FROM raw.events e,
LATERAL FLATTEN(INPUT => e.payload:items) f;
