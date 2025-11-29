-- Define tags once (often in a governance schema)
CREATE TAG classification     ALLOWED_VALUES ('pii.email','pii.phone','pii.ssn','restricted','public');
CREATE TAG owner              ALLOWED_VALUES ('fin-data','mkt-analytics','ops-data','eng-data');
CREATE TAG retention_policy   ALLOWED_VALUES ('7d','14d','30d','indefinite');

-- Attach tags to objects
ALTER TABLE core.dim_customer
  SET TAG owner = 'fin-data', data_domain = 'customer';

-- Tag sensitive columns for enforcement & audits
ALTER TABLE core.dim_customer
  MODIFY COLUMN email SET TAG classification = 'pii.email';
