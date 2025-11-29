from snowflake.snowpark import Session
sess = Session.builder.configs({
  "account": "...", "user": "...", "password": "...",
  "warehouse": "WH_ELT", "role": "TRANSFORMER",
  "database": "CORE", "schema": "PUBLIC",
  "PYTHON_CONNECTOR_QUERY_RESULT_FORMAT": "arrow"
}).create()

# Package hints when creating UDFs/SPs:
# @udf(..., packages=["numpy==1.26.4"], imports=["@code.whl/myutil-0.1-py3-none-any.whl"])
