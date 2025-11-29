CREATE OR REPLACE DATABASE provider_prod_candidate CLONE provider_prod;
-- apply migrations, recompute, validate
ALTER DATABASE provider_prod_candidate SWAP WITH provider_prod;
