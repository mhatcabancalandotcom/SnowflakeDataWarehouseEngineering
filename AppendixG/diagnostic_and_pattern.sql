LIST @mystage/path/;

CREATE OR REPLACE FILE FORMAT ff_json TYPE=JSON STRIP_OUTER_ARRAY=TRUE;

COPY INTO stage.raw_events
FROM @mystage/path
FILE_FORMAT=(FORMAT_NAME=ff_json)
ON_ERROR='CONTINUE';  -- capture rejects for inspection
