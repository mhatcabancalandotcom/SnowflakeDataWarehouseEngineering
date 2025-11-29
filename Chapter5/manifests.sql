COPY INTO raw.orders
FROM @ext_sales
FILES = ('2025-09-25/orders_001.parquet','2025-09-25/orders_002.parquet')
ON_ERROR = 'ABORT_STATEMENT';
