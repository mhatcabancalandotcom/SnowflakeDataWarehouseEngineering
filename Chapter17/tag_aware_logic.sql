CREATE TAG classification ALLOWED_VALUES ('pii.email','pii.phone','pii.ssn','public');

ALTER TABLE dim_customer
  MODIFY COLUMN email SET TAG classification = 'pii.email';
ALTER TABLE dim_customer
  MODIFY COLUMN phone SET TAG classification = 'pii.phone';
