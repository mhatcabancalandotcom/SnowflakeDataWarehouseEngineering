-- Freeze prod at a point (optional: specify AT <timestamp>)
CREATE DATABASE prod_candidate CLONE prod;

-- Run validation/backfill in the clone, then promote by swapping
ALTER DATABASE prod_candidate SWAP WITH prod;  -- atomic rename; sessions continue with the new contents
