SELECT pglogical.create_node(
node_name := 'db-reporting',
  dsn :=  'host=172.16.1.172 port=5432 dbname=code_production user=postgres'
         );

SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.1.51 port=5432 dbname=code_production user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE
);

# SELECT pg_create_logical_replication_slot('pgl_code_production_new_db_master_public', 'pglogical_output');

# select pglogical.drop_subscription('public');
# select pglogical.drop_node('db-slave');
select * from pglogical.subscription;

SELECT pglogical.show_subscription_status('public');
