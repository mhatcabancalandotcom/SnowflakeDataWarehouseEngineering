-- Salted hash for joins
ALTER TABLE core.dim_customer ADD COLUMN email_hash STRING;
UPDATE core.dim_customer
SET email_hash = SHA2(LOWER(email) || ':SALT_v1', 256);
