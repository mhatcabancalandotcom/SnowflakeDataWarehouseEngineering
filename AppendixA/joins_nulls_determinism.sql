SELECT
  COUNT_IF(o.is_won) AS wins,
  COUNT(*)           AS opportunities,
  SAFE_DIVIDE(COUNT_IF(o.is_won), COUNT(*)) AS win_rate  -- custom UDF or handle div-by-zero
FROM core.f_opportunity_daily AS o;
