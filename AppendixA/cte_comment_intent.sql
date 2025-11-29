-- PURPOSE: Daily revenue by segment. Grain = (order_dt, segment).
-- ENVELOPES: order_dt prunes; tenant isolation via RAP on schema.
-- ASSUMPTIONS: dim_customer.is_current is point-in-time correct for reporting day.

WITH deduped AS ( ... ),
ranked_latest AS ( ... )
SELECT ...
