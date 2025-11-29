from typing import Iterable, Tuple
from snowflake.snowpark.types import StructType, StructField, StringType, IntegerType
from snowflake.snowpark.functions import udtf

@udtf(
  output_schema=StructType([StructField("TOKEN", StringType()), StructField("LEN", IntegerType())]),
  name="split_tokens",
  replace=True,
  is_permanent=False
)
class SplitTokens:
    def process(self, text: str) -> Iterable[Tuple[str, int]]:
        if not text: return []
        for t in text.split():
            yield (t, len(t))

session.sql("SELECT * FROM TABLE(split_tokens('a quick snowflake'))").collect()
