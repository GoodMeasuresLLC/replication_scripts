-- canvas new db-slave CANVAS

CREATE EXTENSION pglogical;
set pglogical.conflict_resolution = 'keep_local';
SELECT pglogical.create_node(
node_name := 'db-slave',
  dsn :=  'host=172.16.1.51 port=5432 dbname=canvas_production user=postgres'
         );

SELECT pglogical.create_replication_set(
    set_name := 'public'
  );
  
SELECT pglogical.replication_set_add_all_tables(
'public', 
ARRAY['public'] 
);

SELECT pglogical.replication_set_add_all_sequences(
'public', 
ARRAY['public'],
true 
);



SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.1.79 port=5432 dbname=canvas_production user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE

-- new db-reporting

CREATE EXTENSION pglogical;


set pglogical.conflict_resolution = 'keep_local';
SELECT pglogical.create_node(
node_name := 'db-slave',
  dsn :=  'host=172.16.1.172 port=5432 dbname=canvas_production user=postgres'
         );

SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.1.51 port=5432 dbname=canvas_production user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE
