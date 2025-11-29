SELECT OBJECT_CONSTRUCT(
         'order_id', payload:order_id,
         'item_count', ARRAY_SIZE(payload:items)
       ) AS order_summary
FROM raw.events;
