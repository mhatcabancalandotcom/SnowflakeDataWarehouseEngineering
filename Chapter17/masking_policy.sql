CREATE OR REPLACE MASKING POLICY mask_pii AS (val STRING)
RETURNS STRING ->
  CASE
    WHEN IS_ROLE_IN_SESSION('SECURITYADMIN') OR IS_ROLE_IN_SESSION('ROLE_PII_READER') THEN val
    WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('classification') = 'pii.email'
      THEN REGEXP_REPLACE(val, '(^.).+(@.+$)', '\\1***\\2')
    WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('classification') = 'pii.phone'
      THEN REGEXP_REPLACE(val, '(.{2}).+(.{2})', '\\1****\\2')
    ELSE val
  END;
