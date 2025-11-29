from snowflake.snowpark.types import FloatType
from snowflake.snowpark.functions import udaf

class TDigestUDAF:
    def __init__(self): self.values = []
    def accumulate(self, x: float): 
        if x is not None: self.values.append(float(x))
    def merge(self, other): 
        self.values.extend(other.values)
    def finish(self) -> float:
        vs = sorted(self.values)
        if not vs: return None
        mid = len(vs)//2
        return (vs[mid] if len(vs)%2==1 else (vs[mid-1]+vs[mid])/2.0)

median_udaf = udaf(TDigestUDAF, return_type=FloatType(), name="median_udaf", replace=True)

session.sql("SELECT CUSTOMER_ID, median_udaf(AMOUNT) AS med FROM FACT_ORDERS GROUP BY CUSTOMER_ID").collect()
