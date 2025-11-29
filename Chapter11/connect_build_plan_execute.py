from snowflake.snowpark import Session
from snowflake.snowpark.functions import col, try_to_double, sum as ssum

session = Session.builder.configs({
    "account": "<acct>",
    "user": "<user>",
    "password": "<pwd>",
    "role": "TRANSFORMER",
    "warehouse": "WH_ELT",
    "database": "CORE",
    "schema": "PUBLIC"
}).create()

orders = session.table("CORE.FACT_ORDERS")

silver = (
    orders
    .select("ORDER_ID","CUSTOMER_ID","ORDER_DT","AMOUNT")
    .with_column("AMOUNT_NUM", try_to_double(col("AMOUNT")))
    .filter(col("ORDER_DT") >= "2025-09-01")
)

by_cust = silver.group_by("CUSTOMER_ID").agg(ssum(col("AMOUNT_NUM")).alias("REV"))
by_cust.write.save_as_table("SILVER.REV_BY_CUSTOMER", mode="overwrite")  # CTAS under the hood
