WITH ordered AS (
  SELECT tenant_id, user_id, event_ts, event_type,
         LAG(event_ts) OVER (PARTITION BY tenant_id, user_id ORDER BY event_ts) AS prev_ts
  FROM bronze.events_shaped
  WHERE event_type IN ('page_view','click','purchase')
),
sessionized AS (
  SELECT *,
         CASE WHEN prev_ts IS NULL OR DATEDIFF('minute', prev_ts, event_ts) > 30 THEN 1 ELSE 0 END AS is_new,
         SUM(CASE WHEN prev_ts IS NULL OR DATEDIFF('minute', prev_ts, event_ts) > 30 THEN 1 ELSE 0 END)
           OVER (PARTITION BY tenant_id, user_id ORDER BY event_ts) AS session_seq
  FROM ordered
)
SELECT tenant_id, user_id,
       MIN(event_ts) AS session_start,
       MAX(event_ts) AS session_end,
       COUNT(*)      AS events,
       COUNT_IF(event_type='purchase') AS purchases
FROM sessionized
GROUP BY tenant_id, user_id, session_seq;
