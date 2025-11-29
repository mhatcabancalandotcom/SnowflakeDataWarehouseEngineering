-- Idempotent refresh for the last 2 days of ticks
MERGE INTO ml.user_features_offline t
USING (
  WITH ticks AS (
    SELECT DATE_TRUNC('hour', seq) AS as_of_ts
    FROM TABLE(GENERATOR(TIMELIMIT => 60))  -- synthesize recent hours
    QUALIFY as_of_ts >= DATEADD(day,-2, CURRENT_TIMESTAMP())
  )
  SELECT
    u.user_id,
    k.as_of_ts,
    COUNT_IF(e.event_ts >= DATEADD(day,-7, k.as_of_ts))                        AS txn_cnt_7d,
    SUM(IFF(e.event_ts >= DATEADD(day,-30, k.as_of_ts), e.amount, 0))          AS amt_sum_30d,
    DATEDIFF('minute', MAX(e.event_ts), k.as_of_ts)                             AS last_seen_minutes,
    MAX(u.plan)                                                                 AS plan
  FROM core.users u
  LEFT JOIN core.events e
    ON e.user_id = u.user_id
  JOIN ticks k
  GROUP BY 1,2
) s
ON t.user_id = s.user_id AND t.as_of_ts = s.as_of_ts
WHEN MATCHED THEN UPDATE SET
  txn_cnt_7d = s.txn_cnt_7d,
  amt_sum_30d = s.amt_sum_30d,
  last_seen_minutes = s.last_seen_minutes,
  plan = s.plan
WHEN NOT MATCHED THEN INSERT VALUES (s.user_id, s.as_of_ts, s.txn_cnt_7d, s.amt_sum_30d, s.last_seen_minutes, s.plan);
