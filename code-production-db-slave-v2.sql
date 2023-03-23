-- code-production db-slave with postgres logical replication
CREATE PUBLICATION public FOR TABLES IN SCHEMA public,code
ALTER PUBLICATION public DROP TABLE schema_migrations
CREATE SUBSCRIPTION public
  CONNECTION 'host=172.16.1.79 port=5432 dbname=code_production' PUBLICATION public
  WITH(copy_data=FALSE);
