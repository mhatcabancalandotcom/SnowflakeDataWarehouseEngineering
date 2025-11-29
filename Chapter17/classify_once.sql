-- Tags
CREATE TAG classification ALLOWED_VALUES ('pii.email','pii.phone','pii.name','restricted','public');

-- Mark columns
ALTER TABLE core.dim_customer
  MODIFY COLUMN email SET TAG classification='pii.email';
ALTER TABLE core.dim_customer
  MODIFY COLUMN phone SET TAG classification='pii.phone';

-- Masking policy keyed on the tag
CREATE OR REPLACE MASKING POLICY mask_pii AS (val STRING) RETURNS STRING ->
  CASE
    WHEN IS_ROLE_IN_SESSION('ROLE_PII_READER') THEN val
    WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('classification')='pii.email'
      THEN REGEXP_REPLACE(val,'(^.).+(@.+$)','\\1***\\2')
    WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('classification')='pii.phone'
      THEN REGEXP_REPLACE(val,'(.{2}).+(.{2})','\\1****\\2')
    ELSE val
  END;

ALTER TABLE core.dim_customer MODIFY COLUMN email SET MASKING POLICY mask_pii;
ALTER TABLE core.dim_customer MODIFY COLUMN phone SET MASKING POLICY mask_pii;
