CREATE EXTENSION pglogical;
SELECT pglogical.create_node(
node_name := 'old-db-master',
  dsn :=  'host=172.16.7.245 port=5432 dbname=canvas_staging user=postgres'
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
