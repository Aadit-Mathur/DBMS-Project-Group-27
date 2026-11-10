-- READ-ONLY. Returns ONE text value: a report on the ordering tables, constraints, triggers,
-- functions (full source, e.g. any cancel-order logic added directly in Neon), views and row counts.
-- It contains no passwords or connection strings and no customer data.
WITH t(name) AS (VALUES ('orders'),('order_item'),('payment'),('shipment'),('order_event')),
lines(sec, o, txt) AS (
  SELECT 1, 0, '== SERVER ==' UNION ALL
  SELECT 1, 1, version() UNION ALL
  SELECT 1, 2, 'report time: ' || now()::text UNION ALL

  SELECT 2, 0, E'\n== MIGRATION STATE ==' UNION ALL
  SELECT 2, 1, 'v2 schema applied (record_payment + trg_orders_guard exist): ' ||
        (to_regprocedure('record_payment(bigint,boolean,text,text)') IS NOT NULL
         AND EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_orders_guard' AND NOT tgisinternal))::text UNION ALL
  SELECT 2, 2, 'earlier draft functions present (pay_order / 1-arg cancel_order): ' ||
        (to_regprocedure('pay_order(bigint)') IS NOT NULL OR to_regprocedure('cancel_order(bigint)') IS NOT NULL)::text UNION ALL
  SELECT 2, 3, 'UNEXPECTED triggers on the order tables: ' || COALESCE((
        SELECT string_agg(c.relname || '.' || g.tgname, ', ') FROM pg_trigger g JOIN pg_class c ON c.oid = g.tgrelid
        WHERE NOT g.tgisinternal AND c.relname IN (SELECT name FROM t) AND c.relnamespace = 'public'::regnamespace
          AND g.tgname NOT IN ('trg_order_item_total','trg_order_item_frozen','trg_orders_guard','trg_payment_flow',
                               'trg_shipment_flow','trg_orders_event','trg_payment_event','trg_shipment_event')), 'none') UNION ALL

  SELECT 3, 0, E'\n== ROW COUNTS ==' UNION ALL
  SELECT 3, 1, rpad(name, 12) || COALESCE((xpath('/row/c/text()', query_to_xml(format('select count(*) as c from public.%I', name), false, true, '')))[1]::text, 'table missing')
  FROM t WHERE to_regclass('public.' || name) IS NOT NULL UNION ALL
  SELECT 3, 2, 'missing table: ' || name FROM t WHERE to_regclass('public.' || name) IS NULL UNION ALL
  SELECT 3, 3, 'orders by status:   ' || COALESCE((xpath('/row/s/text()', query_to_xml(
        'select coalesce(string_agg(order_status || ''='' || n, '', ''), ''(empty)'') as s from (select order_status, count(*) n from public.orders group by 1 order by 1) x', false, true, '')))[1]::text, '')
        WHERE to_regclass('public.orders') IS NOT NULL UNION ALL
  SELECT 3, 4, 'payments by status: ' || COALESCE((xpath('/row/s/text()', query_to_xml(
        'select coalesce(string_agg(payment_status || ''='' || n, '', ''), ''(empty)'') as s from (select payment_status, count(*) n from public.payment group by 1 order by 1) x', false, true, '')))[1]::text, '')
        WHERE to_regclass('public.payment') IS NOT NULL UNION ALL

  SELECT 4, 0, E'\n== COLUMNS ==' UNION ALL
  SELECT 4, 1, rpad(c.table_name || '.' || c.column_name, 36) || rpad(c.data_type, 28) ||
         CASE WHEN c.is_nullable = 'NO' THEN 'NOT NULL ' ELSE 'null     ' END ||
         COALESCE('default ' || c.column_default, '') || CASE WHEN c.is_generated = 'ALWAYS' THEN ' GENERATED ' || c.generation_expression ELSE '' END
  FROM information_schema.columns c WHERE c.table_schema = 'public' AND c.table_name IN (SELECT name FROM t) UNION ALL

  SELECT 5, 0, E'\n== CONSTRAINTS ==' UNION ALL
  SELECT 5, 1, rpad(conrelid::regclass::text, 12) || rpad(conname, 32) || pg_get_constraintdef(oid)
  FROM pg_constraint WHERE conrelid IN (SELECT to_regclass('public.' || name) FROM t WHERE to_regclass('public.' || name) IS NOT NULL)
     OR (conrelid = to_regclass('public.address') AND contype = 'u') UNION ALL

  SELECT 6, 0, E'\n== INDEXES ==' UNION ALL
  SELECT 6, 1, indexdef FROM pg_indexes WHERE schemaname = 'public' AND tablename IN (SELECT name FROM t) UNION ALL

  SELECT 7, 0, E'\n== TRIGGERS (non-internal) ==' UNION ALL
  SELECT 7, 1, pg_get_triggerdef(g.oid) FROM pg_trigger g JOIN pg_class c ON c.oid = g.tgrelid
  WHERE NOT g.tgisinternal AND c.relname IN (SELECT name FROM t) AND c.relnamespace = 'public'::regnamespace UNION ALL

  SELECT 8, 0, E'\n== VIEWS ==' UNION ALL
  SELECT 8, 1, 'view ' || viewname || ': ' || regexp_replace(definition, '\s+', ' ', 'g') FROM pg_views
  WHERE schemaname = 'public' AND (definition ~* '\m(orders|payment|shipment|order_item)\M') UNION ALL

  SELECT 9, 0, E'\n== FUNCTIONS (full source; includes anything added directly in Neon) ==' UNION ALL
  SELECT 9, 1, E'-- ' || p.oid::regprocedure::text || E'\n' || pg_get_functiondef(p.oid)
  FROM pg_proc p
  WHERE p.pronamespace = 'public'::regnamespace AND p.prokind = 'f'
    AND NOT EXISTS (SELECT 1 FROM pg_depend d WHERE d.objid = p.oid AND d.deptype = 'e')
    AND (p.proname ~* '(order|pay|ship|cancel|refund|restock|product_touch)' OR p.prosrc ~* '\m(orders|payment|shipment|order_item)\M')
)
SELECT string_agg(txt, E'\n' ORDER BY sec, o, txt) AS report FROM lines;
