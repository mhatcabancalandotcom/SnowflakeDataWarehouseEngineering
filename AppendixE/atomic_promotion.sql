CREATE OR REPLACE DATABASE prod_clone CLONE prod_candidate;
-- sanity checks…
ALTER DATABASE prod_clone SWAP WITH prod;   -- instant cutover
