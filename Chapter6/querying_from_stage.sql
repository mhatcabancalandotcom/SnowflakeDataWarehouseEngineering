-- JSON: one row per JSON object; cast on read
SELECT
  $1:order_id::STRING AS order_id,
  TRY_TO_NUMBER($1:total) AS total
FROM @ext_events (FILE_FORMAT => (TYPE=JSON, STRIP_OUTER_ARRAY=TRUE));

-- Parquet: columns are already typed in the file
SELECT
  $1:order_id::STRING AS order_id,   -- or project as typed with column defs
  $1:total::FLOAT     AS total
FROM @ext_parquet (FILE_FORMAT => (TYPE=PARQUET));
