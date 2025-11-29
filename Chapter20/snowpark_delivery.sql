CREATE OR REPLACE FUNCTION ml.score_churn(v VARIANT, model_version STRING)
RETURNS FLOAT
LANGUAGE PYTHON
RUNTIME_VERSION = '3.10'
PACKAGES = ('joblib','numpy','scikit-learn==1.3.2')
IMPORTS = ('@ops.pkg/snowpark_pkg/v1_2_3.whl')
HANDLER = 'udf_entrypoint.score';
