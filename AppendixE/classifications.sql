CREATE TAG classification;
ALTER TABLE core.dim_customer MODIFY COLUMN email SET TAG classification='pii.email';
-- governance job binds mask_pii to all columns tagged 'pii.*'
