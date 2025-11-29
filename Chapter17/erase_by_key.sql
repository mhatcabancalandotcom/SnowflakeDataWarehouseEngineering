-- Mark subject as erased
UPDATE core.dim_customer SET erased_at = CURRENT_TIMESTAMP()
WHERE customer_id = :subject_id;

-- Optional: blank direct identifiers
UPDATE core.dim_customer
SET email = NULL, phone = NULL
WHERE customer_id = :subject_id;
