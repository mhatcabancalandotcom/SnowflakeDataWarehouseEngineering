-- Snapshot training set (point-in-time safe)
CREATE OR REPLACE TABLE train.churn_2025_09_01 AS
SELECT f.*, l.label
FROM feat.v_customer_features f
JOIN labels.churn l
  ON l.customer_id = f.customer_id
 AND l.as_of_ts    = f.as_of_ts
WHERE f.as_of_ts BETWEEN '2025-06-01' AND '2025-08-31';

-- Deliver to the platform bucket
COPY INTO @ml_exports/churn_2025_09_01/
FROM train.churn_2025_09_01
FILE_FORMAT = (TYPE = PARQUET);
