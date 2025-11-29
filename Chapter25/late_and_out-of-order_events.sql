-- Open window is last 10 minutes; older windows read from stable, pre-aggregated table
WITH open AS (
  SELECT DATE_TRUNC('minute', event_ts) AS t_min, COUNT(*) AS n
  FROM bronze.events_shaped
  WHERE event_ts >= DATEADD(minute,-10,CURRENT_TIMESTAMP())
  GROUP BY 1
)
SELECT * FROM stable.events_by_minute
WHERE t_min < DATEADD(minute,-10,CURRENT_TIMESTAMP())
UNION ALL
SELECT * FROM open;
