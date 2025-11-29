CREATE STORAGE INTEGRATION si_events
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::123456789012:role/sf-snowpipe-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://lake/events/');

CREATE STAGE ext_events
  URL = 's3://lake/events/'
  STORAGE_INTEGRATION = si_events
  FILE_FORMAT = (TYPE = JSON, STRIP_OUTER_ARRAY = TRUE);

CREATE PIPE pipe_events
  AUTO_INGEST = TRUE
  AS
  COPY INTO bronze.events (payload)
  FROM (SELECT $1::VARIANT FROM @ext_events)
  ON_ERROR = 'CONTINUE';  -- keep rejects discoverable via VALIDATE
