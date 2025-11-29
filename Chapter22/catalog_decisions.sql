-- Catalog-approved classification updates
ALTER TABLE core.dim_customer
  MODIFY COLUMN email SET TAG classification = 'pii.email';

ALTER TABLE core.dim_customer
  MODIFY COLUMN phone SET TAG classification = 'pii.phone';

-- Masking attachment from a template policy
ALTER TABLE core.dim_customer
  MODIFY COLUMN email SET MASKING POLICY mask_pii;
