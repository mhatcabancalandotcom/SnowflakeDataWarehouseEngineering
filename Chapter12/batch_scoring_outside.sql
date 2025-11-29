-- Export feature window
COPY INTO @ml_exports/churn_score_batch_2025_09_25/
FROM (
  SELECT entity_id, as_of_ts, cnt_pos_7d, amt_30d, days_since_last
  FROM feat.customer_daily
  WHERE as_of_ts = '2025-09-25'
)
FILE_FORMAT = (TYPE = PARQUET);

-- (External job writes results back to @ml_imports ...)

-- Ingest predictions idempotently
MERGE INTO pred.churn_daily t
USING (
  SELECT $1:entity_id::STRING AS entity_id,
         $1:as_of_ts::TIMESTAMP_NTZ AS as_of_ts,
         'churn_v7' AS model_version,
         $1:score::FLOAT AS score
  FROM @ml_imports/churn_score_batch_2025_09_25/ (FILE_FORMAT => (TYPE = PARQUET))
) s
ON (t.entity_id, t.as_of_ts, t.model_version) = (s.entity_id, s.as_of_ts, s.model_version)
WHEN MATCHED THEN UPDATE SET score = s.score, scored_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT (entity_id, as_of_ts, model_version, score, scored_at)
VALUES (s.entity_id, s.as_of_ts, s.model_version, s.score, CURRENT_TIMESTAMP());
