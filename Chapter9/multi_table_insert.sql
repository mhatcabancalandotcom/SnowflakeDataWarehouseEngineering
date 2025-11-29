-- Split bronze → silver in a single read
INSERT ALL
  WHEN type = 'order_created' THEN
    INTO silver.orders (order_id, customer_id, total, created_at)
    VALUES (payload:order_id::STRING,
            payload:customer_id::STRING,
            TRY_TO_NUMBER(payload:total),
            TO_TIMESTAMP_NTZ(payload:created_at))
  WHEN type = 'order_item' THEN
    INTO silver.order_items (order_id, sku, qty)
    VALUES (payload:order_id::STRING,
            payload:item:sku::STRING,
            payload:item:qty::NUMBER)
SELECT
  payload,
  payload:type::STRING AS type
FROM bronze.events
WHERE ingest_dt = CURRENT_DATE();
