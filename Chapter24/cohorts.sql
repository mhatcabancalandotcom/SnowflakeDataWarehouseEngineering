-- New pipeline created this month (first seen in month)
WITH first_seen AS (
  SELECT opp_id, MIN(snapshot_dt) AS first_dt
  FROM core.f_opportunity_daily
  GROUP BY opp_id
)
SELECT DATE_TRUNC('month', first_dt) AS cohort_month,
       a.segment,
       SUM(d.amount) AS new_pipeline
FROM first_seen f
JOIN core.f_opportunity_daily d USING (opp_id)
JOIN core.dim_account_scd a ON a.account_id = d.account_id AND a.is_current
WHERE DATE_TRUNC('month', first_dt) = DATE_TRUNC('month', CURRENT_DATE())
GROUP BY 1,2;
