Snowflake Data Warehouse Engineering — Repository

This repo contains the runnable code that accompany the book Snowflake Cloud Data Warehouse Engineering. It’s meant to be cloned, edited, and used as a working reference while you build or operate a Snowflake platform.

Quick start

You’ll need a Snowflake account (any edition), a role that can create objects in a sandbox database, and optionally Python 3.10+ if you want to run Snowpark samples.

# 1) Clone
git clone https://github.com/mhatcabancalandotcom/snowflakedatawarehouseengineering.git
cd SnowflakeDataWarehouseEngineering

# 2) (Optional) create and activate a Python env for Snowpark samples
python -m venv .venv && source .venv/bin/activate
pip install -r snowpark/requirements.txt

# 3) Install dbt for Snowflake
pip install dbt-snowflake

# 4) Set Snowflake connection as env vars (example)
export SNOWFLAKE_ACCOUNT="xy12345.eu-central-1"
export SNOWFLAKE_USER="YOUR_USER"
export SNOWFLAKE_PASSWORD="YOUR_PASSWORD"
export SNOWFLAKE_ROLE="ROLE_ELT_WRITER_SALES"
export SNOWFLAKE_WAREHOUSE="WH_ELT_SALES"
export SNOWFLAKE_DATABASE="DEV"
export SNOWFLAKE_SCHEMA="DEV_APP"

Never commit credentials. Prefer SSO/OAuth in real environments. For CI, use the platform’s secret store.