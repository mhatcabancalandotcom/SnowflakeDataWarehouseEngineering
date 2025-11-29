-- Tag predictions with version and policy
SELECT entity_id, as_of_ts,
       CASE WHEN rand() < 0.1 THEN 'churn_v8' ELSE 'churn_v7' END AS model_version,
       score_probability(...) AS p
FROM feat.customer_daily;
