-- code-production db-master
CREATE EXTENSION pglogical;
set pglogical.conflict_resolution = 'keep_local';
SELECT pglogical.create_node(
node_name := 'db-slave',
  dsn :=  'host=172.16.1.79 port=5432 dbname=code_production user=postgres'
         );

SELECT pglogical.create_replication_set(
    set_name := 'public'
  );
  
SELECT pglogical.replication_set_add_all_tables(
'public', 
ARRAY['public','code'] 
);
SELECT pglogical.replication_set_remove_table('public', 'schema_migrations');

SELECT pglogical.replication_set_add_all_sequences(
'public', 
ARRAY['public','code'],
true 
);

-- SELECT * FROM pg_create_logical_replication_slot('pgl_code_production_db_slave_public', 'pglogical_output', false, true);
SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.1.68 port=5432 dbname=code_production user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE
);


SELECT pglogical.replication_set_add_table('public', 'schema_migrations');

