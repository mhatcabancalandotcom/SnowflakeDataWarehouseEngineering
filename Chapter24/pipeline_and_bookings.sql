-- Canonical pipeline snapshot (period end)
CREATE OR REPLACE VIEW sales_mart.v_pipeline AS
SELECT
  d.snapshot_dt AS as_of,
  a.segment,
  a.territory,
  d.stage,
  SUM(d.amount) AS pipeline_amt
FROM core.f_opportunity_daily d
JOIN core.dim_account_scd a
  ON a.account_id = d.account_id
 AND a.is_current
WHERE d.is_open
GROUP BY 1,2,3,4;

-- Bookings (won in period)
CREATE OR REPLACE VIEW sales_mart.v_bookings AS
SELECT
  d.close_dt AS booked_dt,
  a.segment, a.territory,
  SUM(d.amount) AS bookings_amt
FROM core.f_opportunity_daily d
JOIN core.dim_account_scd a
  ON a.account_id = d.account_id AND a.is_current
WHERE d.is_won
GROUP BY 1,2,3;
