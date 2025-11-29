-- Parquet, sized ~200 MB per object, date-partitioned in S3
COPY INTO core.fact_orders
FROM @ext_sales/date_dt=2025-09-25/
FILE_FORMAT = (TYPE = PARQUET)
ON_ERROR = 'ABORT_STATEMENT'
PURGE = FALSE;  -- keep data lake as source of truth
