SELECT
  payload:order_id::STRING                         AS order_id,
  TRY_TO_NUMBER(payload:total)                     AS total,
  TO_TIMESTAMP_NTZ(payload:created_at)             AS created_at
FROM bronze.events
WHERE payload:type::STRING = 'order_created';
