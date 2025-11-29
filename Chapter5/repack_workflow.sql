-- (Conceptual) Repack workflow
-- 1) Land tiny CSVs to internal stage
-- 2) Create a transient table, load with CONTINUE, then CTAS → Parquet
CREATE OR REPLACE TABLE work.orders_clean AS
SELECT * FROM raw.orders  -- after validation & casting
;

-- 3) Unload to balanced Parquet for future loads (or downstream sharing)
COPY INTO @stg_sales_balanced
FROM work.orders_clean
FILE_FORMAT = (TYPE = PARQUET, COMPRESSION = 'SNAPPY')
HEADER = FALSE
OVERWRITE = TRUE
MAX_FILE_SIZE = 200*1024*1024;  -- ~200 MB
