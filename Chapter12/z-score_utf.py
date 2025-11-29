from snowflake.snowpark.functions import udf
from snowflake.snowpark.types import FloatType

@udf(name="winsor", replace=True, is_permanent=False, return_type=FloatType())
def winsor(x: float, lo: float, hi: float) -> float:
    if x is None: return None
    return max(lo, min(hi, x))
