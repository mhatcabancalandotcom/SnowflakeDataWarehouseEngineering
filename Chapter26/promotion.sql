CREATE OR REPLACE DATABASE prod_sales_candidate CLONE prod_sales;
/* apply migrations, compute, tests */
ALTER DATABASE prod_sales_candidate SWAP WITH prod_sales;
