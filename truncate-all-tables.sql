DO
$do$
BEGIN
   -- dangerous, test before you execute!
   -- RAISE NOTICE '%',  -- once confident, comment this line ...
   EXECUTE         -- ... and uncomment this one
   (SELECT 'TRUNCATE TABLE ' || string_agg(oid::regclass::text, ', ') || ' CASCADE'
    FROM   pg_class
    WHERE  relkind = 'r'  -- only tables
    AND    (relnamespace = 'public'::regnamespace OR relnamespace = 'code'::regnamespace)
   );
END
$do$;
