-- code-staging db-slave
CREATE EXTENSION pglogical;
set pglogical.conflict_resolution = 'keep_local';
SELECT pglogical.create_node(
node_name := 'db-slave',
  dsn :=  'host=172.16.7.125 port=5432 dbname=canvas_staging user=postgres'
         );

drop table quiz_submission_events_2023_2;
drop table quiz_submission_events_2023_3;
drop table quiz_submission_events_2023_4;
drop table quiz_submission_events_2023_5;

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
provider_dsn :=  'host=172.16.7.93 port=5432 dbname=canvas_staging user=postgres',
replication_sets := '{public}',
synchronize_data := TRUE
);

-- SELECT * FROM pg_create_logical_replication_slot('pgl_code_production_db_slave_public', 'pglogical_output', false, true);
