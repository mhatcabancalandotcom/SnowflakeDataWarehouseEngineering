CREATE TABLE sales_rules.territory_map (
  as_of DATE,
  account_id STRING,
  owner_user_id STRING,
  territory STRING,
  credit_pct NUMBER(5,2) DEFAULT 1.00  -- supports split credit
);

-- Attribution view
CREATE OR REPLACE VIEW sales_mart.v_attributed_bookings AS
SELECT
  b.booked_dt, r.territory, r.owner_user_id,
  b.bookings_amt * r.credit_pct AS credited_amt
FROM sales_mart.v_bookings b
JOIN sales_rules.territory_map r
  ON r.account_id = b.account_id
 AND r.as_of <= b.booked_dt
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY b.account_id, b.booked_dt
  ORDER BY r.as_of DESC
) = 1;  -- pick the latest mapping at booking time
