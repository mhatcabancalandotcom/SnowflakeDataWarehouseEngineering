-- Count and sum deltas by day (source exported vs. Snowflake landed)
SELECT d, src_cnt, tgt_cnt, src_amt, tgt_amt,
       (tgt_cnt-src_cnt) AS cnt_delta, (tgt_amt-src_amt) AS amt_delta
FROM (
  SELECT d, COUNT(*) src_cnt, SUM(amount) src_amt FROM src.orders GROUP BY d
) s
JOIN (
  SELECT d, COUNT(*) tgt_cnt, SUM(amount) tgt_amt FROM raw.fact_orders_like_source GROUP BY d
) t USING (d)
ORDER BY d DESC;
