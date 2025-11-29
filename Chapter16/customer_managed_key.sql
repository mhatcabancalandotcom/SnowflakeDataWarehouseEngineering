-- App registration differs per cloud; this binds Snowflake to your KMS and storage
CREATE OR REPLACE STORAGE INTEGRATION si_lake
  TYPE = EXTERNAL_STAGE
  ENABLED = TRUE
  STORAGE_PROVIDER = 'S3'                     -- or 'AZURE' / 'GCS'
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::123456789012:role/snowflake-stage'
  STORAGE_ALLOWED_LOCATIONS = ('s3://my-bucket/data/')
  -- enforce bucket-side KMS
  COMMENT = 'Access via role; bucket enforces SSE-KMS';

-- Stage that *requires* KMS on S3 objects
CREATE OR REPLACE STAGE lake_sales
  URL = 's3://my-bucket/data/sales/'
  STORAGE_INTEGRATION = si_lake
  ENCRYPTION = (TYPE = 'AWS_SSE_KMS' KMS_KEY_ID = 'arn:aws:kms:us-east-1:123456789012:key/abcd-...');

-- GCS/ADLS equivalents:
-- ENCRYPTION = (TYPE='GCS_SSE_KMS', KMS_KEY='projects/.../cryptoKeys/...') 
-- ENCRYPTION = (TYPE='AZURE_CEK', ... ) when applicable.
