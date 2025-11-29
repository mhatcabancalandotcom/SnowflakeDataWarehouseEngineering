CREATE STAGE lake_sales
  URL = 's3://datalake/sales/'
  STORAGE_INTEGRATION = si_lake
  FILE_FORMAT = (TYPE = PARQUET);

CREATE EXTERNAL TABLE ext.sales
  WITH LOCATION = @lake_sales
  AUTO_REFRESH = TRUE
  FILE_FORMAT = (TYPE = PARQUET);

-- Project typed fields and leverage partition folders for pruning
SELECT
  value:order_id::STRING AS order_id,
  value:total::NUMBER    AS total,
  METADATA$FILENAME      AS src_file
FROM ext.sales
WHERE METADATA$FILE_LAST_MODIFIED >= DATEADD(day, -1, CURRENT_TIMESTAMP());
