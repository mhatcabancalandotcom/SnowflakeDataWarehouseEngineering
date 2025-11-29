CREATE TABLE plan.t_forecast (
  submitted_at TIMESTAMP_NTZ,
  horizon      STRING,           -- 'current_q','next_q'
  owner_user_id STRING,
  territory STRING,
  stage_floor STRING,            -- e.g., 'Commit' => include Commit+ stages
  forecast_amt NUMBER(18,2),
  version STRING                 -- 'baseline','upside','downside'
);

-- Reconciliation: forecast vs. realized bookings for the same cohort
CREATE OR REPLACE VIEW plan.v_forecast_vs_actual AS
SELECT
  DATE_TRUNC('quarter', submitted_at)::DATE AS quarter,
  version,
  territory,
  SUM(forecast_amt) AS fcst,
  (SELECT COALESCE(SUM(bookings_amt),0)
     FROM sales_mart.v_bookings b
     WHERE DATE_TRUNC('quarter', b.booked_dt) = DATE_TRUNC('quarter', submitted_at)
       AND b.territory = p.territory) AS actual
FROM plan.t_forecast p
GROUP BY 1,2,3;
