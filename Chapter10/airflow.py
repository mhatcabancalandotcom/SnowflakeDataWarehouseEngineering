from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from datetime import datetime

with DAG("elt_orders", start_date=datetime(2025, 9, 1), schedule="@hourly", catchup=False) as dag:
    resume = SnowflakeOperator(
        task_id="resume_task_tree",
        sql="ALTER TASK t_normalize RESUME; ALTER TASK t_orders RESUME; ALTER TASK t_items RESUME;"
    )
    run_now = SnowflakeOperator(
        task_id="kick_tasks",
        sql="ALTER TASK t_normalize EXECUTE IMMEDIATE TASK;"
    )
    pause = SnowflakeOperator(
        task_id="pause_task_tree",
        trigger_rule="all_done",
        sql="ALTER TASK t_normalize SUSPEND; ALTER TASK t_orders SUSPEND; ALTER TASK t_items SUSPEND;"
    )
    resume >> run_now >> pause
