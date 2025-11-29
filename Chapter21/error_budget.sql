CREATE TABLE IF NOT EXISTS ops.error_budget_bi_weekly (
  week_start DATE PRIMARY KEY,
  minutes_budget NUMBER, minutes_spent NUMBER, notes STRING
);
