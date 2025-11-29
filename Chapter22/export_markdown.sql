-- Write files: one index per schema
COPY INTO @docs_stage/index/
  FROM (SELECT md FROM docs.v_markdown_index)
  FILE_FORMAT = (TYPE=CSV FIELD_DELIMITER='|' FIELD_OPTIONALLY_ENCLOSED_BY='"' ESCAPE_UNENCLOSED_FIELD = NONE)
  HEADER=FALSE OVERWRITE=TRUE SINGLE=TRUE;  -- SINGLE keeps one file

-- Write dataset pages (one row per object becomes a tiny file)
COPY INTO @docs_stage/datasets/
  FROM (
    SELECT obj || '.md' AS name, md
    FROM docs.v_markdown_columns
  )
  FILE_FORMAT=(TYPE=CSV FIELD_DELIMITER='|' SKIP_HEADER=0)
  HEADER=FALSE OVERWRITE=TRUE;
