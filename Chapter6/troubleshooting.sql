-- See file set and partitions touched by an external-table query
EXPLAIN USING text
SELECT ...
FROM lake.orders_parquet
WHERE value:event_dt::DATE = CURRENT_DATE();

-- Validate staged records before a load changes table state
COPY INTO bronze.events
FROM @ext_events
FILE_FORMAT = (TYPE=JSON, STRIP_OUTER_ARRAY=TRUE)
VALIDATION_MODE = 'RETURN_ERRORS';
