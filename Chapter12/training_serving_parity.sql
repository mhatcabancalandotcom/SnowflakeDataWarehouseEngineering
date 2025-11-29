CREATE OR REPLACE VIEW feat.v_customer_features AS
SELECT * FROM feat.customer_daily;

-- Training set for a historical window (labels joined separately)
SELECT *
FROM feat.v_customer_features
WHERE as_of_ts BETWEEN '2025-06-01' AND '2025-08-31';

-- Serving for the most recent day
SELECT *
FROM feat.v_customer_features
WHERE as_of_ts = DATE_TRUNC('day', CURRENT_DATE());
