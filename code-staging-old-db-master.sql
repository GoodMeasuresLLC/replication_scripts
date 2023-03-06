-- old code-staging-db-master
CREATE EXTENSION pglogical;
SELECT pglogical.create_node(
node_name := 'old-db-master',
  dsn :=  'host=172.16.7.245 port=5432 dbname=code_staging user=postgres'
         );

SELECT pglogical.create_replication_set(
    set_name := 'public'
  );
  
SELECT pglogical.replication_set_add_all_tables(
'public', 
ARRAY['public','code'] 
);

SELECT pglogical.replication_set_add_all_sequences(
'public', 
ARRAY['public','code'],
true 
);
