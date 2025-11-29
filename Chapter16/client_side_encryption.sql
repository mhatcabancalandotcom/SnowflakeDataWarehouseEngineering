-- For S3 external stages only (illustrative)
CREATE OR REPLACE STAGE ext_raw
  URL='s3://my-bucket/raw/'
  ENCRYPTION = (TYPE='AWS_CSE' MASTER_KEY='base64-encoded-key-material');
