-- Create the external stage (AWS example)
CREATE STORAGE INTEGRATION si_s3
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<arn:aws:iam::...:role/snowflake-stage-role>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://company-migration/');

CREATE STAGE stg_mig
  STORAGE_INTEGRATION = si_s3
  URL = 's3://company-migration/source=db/table=fact_orders/';

CREATE FILE FORMAT ff_parquet TYPE = PARQUET;

-- Load to Snowflake landing (one table)
CREATE OR REPLACE TABLE raw.fact_orders_like_source LIKE TEMPLATE_DB.PUBLIC.FACT_ORDERS;

COPY INTO raw.fact_orders_like_source
  FROM @stg_mig
  FILE_FORMAT = (FORMAT_NAME = ff_parquet)
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
  ON_ERROR = 'ABORT_STATEMENT';
