-- code-production db-master via builting logical replication
set pglogical.conflict_resolution = 'keep_local';
SELECT pglogical.create_node(
node_name := 'db-master',
  dsn :=  'host=172.16.1.79 port=5432 dbname=code_production user=postgres'
         );
SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.1.68 port=5432 dbname=code_production user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE
);

CREATE PUBLICATION public FOR TABLES IN SCHEMA public,code
ALTER PUBLICATION public DROP TABLE schema_migrations

