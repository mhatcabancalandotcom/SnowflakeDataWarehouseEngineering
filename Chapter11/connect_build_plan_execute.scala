import com.snowflake.snowpark._
import com.snowflake.snowpark.functions._

val session = Session.builder.configs(Map(
  "URL" -> "<acct>.snowflakecomputing.com",
  "USER" -> "user",
  "PASSWORD" -> "pwd",
  "ROLE" -> "TRANSFORMER",
  "WAREHOUSE" -> "WH_ELT",
  "DB" -> "CORE",
  "SCHEMA" -> "PUBLIC"
)).create

val orders = session.table("CORE.FACT_ORDERS")
val byCust = orders
  .filter(col("ORDER_DT") >= lit("2025-09-01"))
  .groupBy(col("CUSTOMER_ID"))
  .agg(sum(col("AMOUNT")).as("REV"))

byCust.write.saveAsTable("SILVER.REV_BY_CUSTOMER", SaveMode.Overwrite)
