-- Mask contact email; allow only specific roles to see plaintext
CREATE OR REPLACE MASKING POLICY mask_email AS (val STRING) RETURNS STRING ->
  CASE WHEN IS_ROLE_IN_SESSION('ROLE_SALES_PII') THEN val
       ELSE REGEXP_REPLACE(val, '(^.).+(@.+$)', '\\1***\\2') END;

ALTER TABLE core.dim_account_scd
  MODIFY COLUMN owner_email SET MASKING POLICY mask_email;

-- Territory-based row access
CREATE OR REPLACE ROW ACCESS POLICY rap_territory AS (territory STRING)
RETURNS BOOLEAN ->
  EXISTS (SELECT 1 FROM gov.user_territories m
          WHERE m.user_name = CURRENT_USER()
            AND m.territory = territory);

ALTER VIEW sales_mart.v_pipeline ADD ROW ACCESS POLICY rap_territory ON (territory);
