-- Lists every constraint, index and trigger on the Seller & Products tables.
-- Read-only.  Run:  python db/run_sql.py db/inspect_constraints.sql
SELECT rel.relname                      AS table_name,
       con.conname                      AS name,
       CASE con.contype WHEN 'p' THEN 'PRIMARY KEY' WHEN 'f' THEN 'FOREIGN KEY'
                        WHEN 'u' THEN 'UNIQUE'      WHEN 'c' THEN 'CHECK'
                        WHEN 'n' THEN 'NOT NULL' END AS kind,
       pg_get_constraintdef(con.oid)    AS definition
FROM   pg_constraint con
JOIN   pg_class rel ON rel.oid = con.conrelid
WHERE  rel.relname IN ('seller', 'category', 'product', 'order_item')
UNION ALL
SELECT tablename, indexname, 'INDEX', indexdef
FROM   pg_indexes
WHERE  tablename IN ('seller', 'category', 'product')
UNION ALL
SELECT event_object_table, trigger_name, 'TRIGGER', action_timing || ' ' || event_manipulation
FROM   information_schema.triggers
WHERE  event_object_table IN ('seller', 'category', 'product')
ORDER  BY 1, 3, 2;
