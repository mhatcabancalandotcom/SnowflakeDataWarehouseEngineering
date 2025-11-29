-- Storing and inspecting
CREATE TABLE raw.events (tenant STRING, arrived_at TIMESTAMP_NTZ, payload VARIANT);

INSERT INTO raw.events VALUES
  ('acme', CURRENT_TIMESTAMP(), PARSE_JSON('{"order_id":"o-1","items":[{"sku":"A","qty":2}]}'));

SELECT 
  payload:order_id::STRING             AS order_id,
  payload:items[0]:sku::STRING         AS first_sku,
  IS_ARRAY(payload:items)              AS has_items
FROM raw.events;
