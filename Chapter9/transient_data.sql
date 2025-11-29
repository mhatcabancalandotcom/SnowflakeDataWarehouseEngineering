-- Session variable
SET as_of = TO_DATE('2025-09-01');

-- Temporary table lives for this session only
CREATE TEMP TABLE work_recent AS
SELECT * FROM core.fact_orders WHERE order_dt >= $as_of;
