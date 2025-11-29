CREATE DATABASE prod_fix CLONE prod;
/* apply corrections and reprocess */
ALTER DATABASE prod_fix SWAP WITH prod;  -- atomic promotion
