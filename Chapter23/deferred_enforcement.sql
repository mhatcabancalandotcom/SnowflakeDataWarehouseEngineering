ALTER TABLE mart.fact_orders
  MODIFY COLUMN customer_email SET TAG classification='pii.email';

-- Existing generic masking policy will apply without new code
