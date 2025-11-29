-- Internal named stage with default file format
CREATE STAGE stg_sales
  FILE_FORMAT = (TYPE = PARQUET);

-- External stage to S3 (via storage integration)
CREATE STORAGE INTEGRATION si_raw
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::123456789012:role/sf-stage-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://my-raw/sales/');

CREATE STAGE ext_sales
  URL = 's3://my-raw/sales/'
  STORAGE_INTEGRATION = si_raw
  FILE_FORMAT = (TYPE = PARQUET);
