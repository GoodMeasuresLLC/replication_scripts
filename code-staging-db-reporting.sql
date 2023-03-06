CREATE EXTENSION pglogical;
set pglogical.conflict_resolution = keep_local;
SELECT pglogical.create_node(
node_name := 'db-reporting',
  dsn :=  'host=172.16.7.109 port=5432 dbname=code_staging user=postgres'
         );

SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.7.125 port=5432 dbname=code_staging user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE);


