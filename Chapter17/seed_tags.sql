-- Inspect likely categories for a table's columns
SELECT SYSTEM$EXTRACT_SEMANTIC_CATEGORIES('CORE','PUBLIC','DIM_CUSTOMER');

-- Apply recommended tags (review before running in prod)
CALL SYSTEM$ASSOCIATE_SEMANTIC_CATEGORY_TAGS('CORE','PUBLIC','DIM_CUSTOMER');
