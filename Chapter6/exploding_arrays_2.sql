SELECT
  rec.$1:order_id::STRING AS order_id,
  item.value:sku::STRING  AS sku,
  item.value:qty::NUMBER  AS qty
FROM @ext_events rec (FILE_FORMAT => (TYPE=JSON, STRIP_OUTER_ARRAY=TRUE)),
LATERAL FLATTEN(INPUT => rec.$1:items) AS item;
