from prefect import flow, task
from snowflake.connector import connect

@task(retries=3, retry_delay_seconds=30)
def run_sql(sql):
    with connect(...) as con:
        con.cursor().execute(sql)

@flow
def elt_flow():
    run_sql.submit("ALTER TASK t_normalize EXECUTE IMMEDIATE TASK;")
    run_sql.submit("ALTER TASK t_orders EXECUTE IMMEDIATE TASK;")
    run_sql.submit("ALTER TASK t_items EXECUTE IMMEDIATE TASK;")

if __name__ == "__main__":
    elt_flow()
