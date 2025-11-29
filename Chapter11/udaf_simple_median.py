from snowflake.snowpark.functions import udaf
from snowflake.snowpark.types import FloatType

class MedianUDAF:
    def __init__(self): self.v=[]
    def accumulate(self, x): 
        if x is not None: self.v.append(float(x))
    def merge(self, other): self.v.extend(other.v)
    def finish(self):
        if not self.v: return None
        s = sorted(self.v); n=len(s); m=n//2
        return s[m] if n%2 else (s[m-1]+s[m])/2

median_udaf = udaf(MedianUDAF, return_type=FloatType(), name="median_udaf", replace=True)
