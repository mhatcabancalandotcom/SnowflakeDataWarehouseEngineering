CREATE OR REPLACE MASKING POLICY mask_pii AS (val STRING) RETURNS STRING ->
  CASE
    WHEN CURRENT_ROLE() IN ('SECURITYADMIN','ROLE_FIN_OWNER') THEN val
    WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('classification') IN ('pii.email','pii.phone') THEN
      REGEXP_REPLACE(val, '(^.).+(@?.+$)', '\\1***\\2')
    ELSE val
  END;

-- Apply once; logic adapts per-tagged column
ALTER TABLE core.dim_customer MODIFY COLUMN email SET MASKING POLICY mask_pii;
ALTER TABLE core.dim_customer MODIFY COLUMN phone SET MASKING POLICY mask_pii;
