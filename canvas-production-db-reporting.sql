-- CANVAS-production db-reporting
CREATE EXTENSION pglogical;
set pglogical.conflict_resolution = 'keep_local';
SELECT pglogical.create_node(
node_name := 'db-reporting',
  dsn :=  'host=172.16.1.172 port=5432 dbname=canvas_production user=postgres'
         );

SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.1.51 port=5432 dbname=canvas_production user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE
);
SELECT pglogical.show_subscription_status('public');
