COPY INTO raw.orders
FROM @ext_sales/date_dt=2025-09-25/
FILE_FORMAT = (TYPE = PARQUET);
