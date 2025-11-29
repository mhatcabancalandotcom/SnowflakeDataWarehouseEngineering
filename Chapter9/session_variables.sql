SET cutoff = DATEADD('day', -30, CURRENT_DATE());
SELECT COUNT(*) FROM core.fact_orders WHERE order_dt >= $cutoff;
