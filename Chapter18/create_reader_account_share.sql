-- Create a managed reader account
CREATE MANAGED ACCOUNT reader_acme
  ADMIN_NAME = 'acme_admin'
  ADMIN_PASSWORD = 'StrongPass!23'
  TYPE = READER;

-- Create a warehouse for the reader (in provider account)
CREATE WAREHOUSE wh_reader_acme WAREHOUSE_SIZE='XSMALL' AUTO_SUSPEND=60 AUTO_RESUME=TRUE;

-- Grant the warehouse to the reader
GRANT USAGE ON WAREHOUSE wh_reader_acme TO SHARE reader_acme;

-- Share data to the reader
CREATE OR REPLACE SHARE sales_public_reader;
GRANT USAGE ON DATABASE SALES TO SHARE sales_public_reader;
GRANT USAGE ON SCHEMA   SALES.MART TO SHARE sales_public_reader;
GRANT SELECT ON VIEW SALES.MART.V_ORDERS_V1 TO SHARE sales_public_reader;

ALTER SHARE sales_public_reader ADD ACCOUNTS = ('reader_acme');
