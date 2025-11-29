from snowflake.snowpark import Session
from snowflake.snowpark.types import StringType
from snowflake.snowpark.functions import sproc

@sproc(name="ops.backfill_orders", replace=True, is_permanent=False, return_type=StringType())
def backfill_orders(session: Session, days: int) -> str:
    session.sql(f"""
        MERGE INTO mart.fact_orders t
        USING (
          SELECT * FROM stage.orders_norm
          WHERE event_ts >= DATEADD('day', -{days}, CURRENT_TIMESTAMP())
        ) s
        ON t.order_id = s.order_id
        WHEN MATCHED THEN UPDATE SET amount = s.total, order_ts = s.event_ts
        WHEN NOT MATCHED THEN INSERT (order_id, customer_id, amount, order_ts)
        VALUES (s.order_id, s.customer_id, s.total, s.event_ts);
    """).collect()
    return f"Backfilled {days} days"
