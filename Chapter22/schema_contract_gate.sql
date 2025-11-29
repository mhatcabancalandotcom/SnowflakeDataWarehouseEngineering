-- Required columns on the public view
SELECT column_name, data_type
FROM prod_candidate.information_schema.columns
WHERE table_schema='MART' AND table_name='V_ORDERS'
QUALIFY COUNT(*) OVER (PARTITION BY column_name)=1;  -- returns 1 row per expected column
