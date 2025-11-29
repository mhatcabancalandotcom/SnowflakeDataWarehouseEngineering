ALTER SESSION SET QUERY_TAG='app=elt;pipeline=orders_daily;release=v2025.10.19';

CREATE TABLE IF NOT EXISTS ops.release_log (
  ts TIMESTAMP_NTZ, release_id STRING, actor STRING, notes STRING
);
