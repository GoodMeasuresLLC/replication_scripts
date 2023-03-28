DO
$do$
DECLARE
   _sql text;
BEGIN
  FOR _sql IN
     SELECT
        'SELECT SETVAL(' ||
           quote_literal(quote_ident(sequence_namespace.nspname) || '.' || quote_ident(class_sequence.relname)) ||
           ', (SELECT COALESCE(MAX(' ||quote_ident(pg_attribute.attname)|| ') + 1, 1) FROM ' ||
           quote_ident(table_namespace.nspname)|| '.'||quote_ident(class_table.relname)|| '), FALSE );'
    FROM pg_depend
        INNER JOIN pg_class AS class_sequence
            ON class_sequence.oid = pg_depend.objid
                AND class_sequence.relkind = 'S'
        INNER JOIN pg_class AS class_table
            ON class_table.oid = pg_depend.refobjid
        INNER JOIN pg_attribute
            ON pg_attribute.attrelid = class_table.oid
                AND pg_depend.refobjsubid = pg_attribute.attnum
        INNER JOIN pg_namespace as table_namespace
            ON table_namespace.oid = class_table.relnamespace
        INNER JOIN pg_namespace AS sequence_namespace
            ON sequence_namespace.oid = class_sequence.relnamespace
    WHERE quote_ident(table_namespace.nspname)|| '.'||quote_ident(class_table.relname) != 'public.model_servings'
    ORDER BY sequence_namespace.nspname, class_sequence.relname
  LOOP
    EXECUTE _sql;
  END LOOP;
END
$do$;
