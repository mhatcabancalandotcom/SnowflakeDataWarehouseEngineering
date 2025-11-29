CREATE OR REPLACE VIEW stage.orders_norm AS
SELECT
  payload:order_id::STRING          AS order_id,
  payload:customer_id::STRING       AS customer_id,
  TRY_TO_NUMBER(payload:total)      AS total,
  TRY_TO_TIMESTAMP_NTZ(payload:ts)  AS event_ts,
  payload:op::STRING                AS op   -- 'I','U','D'
FROM bronze.events
WHERE payload:type::STRING = 'order';

CREATE OR REPLACE STREAM str_orders ON VIEW stage.orders_norm;
