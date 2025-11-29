-- Freshness and row counts compare
SELECT * FROM ops.v_freshness;
SELECT COUNT(*) FROM mart.fact_orders WHERE load_dt = CURRENT_DATE();

-- Access smoke
EXPLAIN USING TEXT SELECT * FROM mart.v_orders LIMIT 1;
