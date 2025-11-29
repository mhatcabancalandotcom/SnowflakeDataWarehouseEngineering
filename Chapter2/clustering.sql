-- See whether a table's layout helps your filters
SELECT system$clustering_information('FACT_EVENTS');

-- Add a clustering key only if selective predicates suffer
ALTER TABLE fact_events
  CLUSTER BY (event_dt, user_id);
