-- Staging table populated by catalog export (db, sch, obj, col, tag, val)
MERGE INTO gov.pending_tags t
USING @stage/catalog_tags.csv FILE_FORMAT=(TYPE=CSV SKIP_HEADER=1) s
ON t.db=s.$1 AND t.sch=s.$2 AND t.obj=s.$3 AND COALESCE(t.col,'')=COALESCE(s.$4,'')
WHEN NOT MATCHED THEN INSERT (db,sch,obj,col,tag,val) VALUES (s.$1,s.$2,s.$3,s.$4,s.$5,s.$6);
