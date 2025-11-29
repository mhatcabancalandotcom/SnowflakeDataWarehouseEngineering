-- Example layout
CREATE TABLE nlp.product_text_features (
  product_id STRING PRIMARY KEY,
  updated_at TIMESTAMP_NTZ,
  embedding  VECTOR(768)  -- or VARIANT if VECTOR not available
);
