SELECT
  e.payload:order_id::STRING AS order_id,
  i.value:sku::STRING        AS sku,
  i.value:qty::NUMBER        AS qty
FROM bronze.events e,
LATERAL FLATTEN(INPUT => e.payload:items) i;
