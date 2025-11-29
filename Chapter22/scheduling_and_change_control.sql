CREATE OR REPLACE TASK docs.t_generate
  WAREHOUSE = wh_ops
  SCHEDULE  = 'USING CRON 15 * * * * UTC'
AS
BEGIN
  -- Optional: snapshot ACCESS_HISTORY to docs.t_usage_daily first
  -- Then regenerate files
  COPY INTO @docs_stage/index/   FROM (SELECT md FROM docs.v_markdown_index)   FILE_FORMAT=(TYPE=CSV FIELD_DELIMITER='|') OVERWRITE=TRUE SINGLE=TRUE;
  COPY INTO @docs_stage/datasets/ FROM (SELECT obj||'.md', md FROM docs.v_markdown_columns) FILE_FORMAT=(TYPE=CSV FIELD_DELIMITER='|') OVERWRITE=TRUE;
END;

ALTER TASK docs.t_generate RESUME;
