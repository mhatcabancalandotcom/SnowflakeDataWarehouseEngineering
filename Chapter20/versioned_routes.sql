CREATE OR REPLACE VIEW ml.v_score_router AS
SELECT CASE
         WHEN CURRENT_TIMESTAMP() < '2025-11-15' THEN 'v1_2_2'
         ELSE 'v1_3_0'
       END AS model_version;

-- UDF reads the router to choose the artifact
CREATE OR REPLACE FUNCTION ml.score_customer(x VARIANT)
RETURNS FLOAT
AS
$$
  import _router
  v = _router.version()  # consults ml.v_score_router
  return _score_with(v, x)
$$
LANGUAGE PYTHON
IMPORTS = ('@ops.pkg/model/v1_2_2.whl','@ops.pkg/model/v1_3_0.whl');
