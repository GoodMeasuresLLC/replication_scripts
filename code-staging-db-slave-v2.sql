-- code-staging db-slave
CREATE PUBLICATION public FOR TABLES IN SCHEMA public,code
ALTER PUBLICATION public DROP TABLE schema_migrations
CREATE SUBSCRIPTION public

CREATE SUBSCRIPTION public
  CONNECTION 'host=172.16.7.93 port=5432 dbname=code_staging' PUBLICATION public
  WITH(copy_data=FALSE);

