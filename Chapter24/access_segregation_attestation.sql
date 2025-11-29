-- Entity scoping
CREATE OR REPLACE ROW ACCESS POLICY rap_entity AS (entity_id STRING)
RETURNS BOOLEAN ->
  EXISTS (SELECT 1 FROM gov.user_entities m
          WHERE m.user_name = CURRENT_USER()
            AND m.entity_id = entity_id);

ALTER TABLE core.f_journal ADD ROW ACCESS POLICY rap_entity ON (entity_id);
