MERGE INTO raw.events_json t
USING stage.events_ingest s
  ON t.tenant_id = s.tenant_id AND t.event_id = s.event_id
WHEN MATCHED THEN UPDATE SET
  payload = s.payload, event_ts = s.event_ts               -- last-write-wins if needed
WHEN NOT MATCHED THEN
  INSERT (src, received_ts, event_ts, event_date, tenant_id, user_id, device_id, event_type, event_id, payload)
  VALUES (s.src, s.received_ts, s.event_ts, TO_DATE(s.event_ts), s.tenant_id, s.user_id, s.device_id, s.event_type, s.event_id, s.payload);
