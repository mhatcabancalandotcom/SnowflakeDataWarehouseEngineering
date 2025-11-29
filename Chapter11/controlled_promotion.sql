CREATE OR REPLACE PROCEDURE ops.swap_mart(src_schema STRING, tgt_schema STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$
var sqlCmd = "ALTER SCHEMA " + src_schema + " SWAP WITH " + tgt_schema;
var attempts = 0;
while (attempts < 3) {
  try {
    snowflake.execute({sqlText: sqlCmd});
    return "SWAP OK";
  } catch (e) {
    attempts++;
    snowflake.execute({sqlText: "CALL system$wait(5)"}); // brief backoff
    if (attempts == 3) { throw e; }
  }
}
$$;
