-- Allow load to proceed; record rejects for later triage
COPY INTO raw.orders
FROM @ext_sales
ON_ERROR = 'CONTINUE'
PURGE = FALSE;

-- Materialize rejects (with file/row context) into a DLQ table
CREATE OR REPLACE TABLE ops.orders_rejects AS
SELECT *
FROM TABLE(VALIDATE(
  TABLE_NAME => 'RAW.ORDERS',
  JOB_ID     => LAST_QUERY_ID()
));
