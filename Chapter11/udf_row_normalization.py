from snowflake.snowpark.functions import udf
from snowflake.snowpark.types import StringType

@udf(name="norm_email", replace=True, is_permanent=False, return_type=StringType())
def norm_email(s: str) -> str:
    if s is None: return None
    return s.strip().lower()
