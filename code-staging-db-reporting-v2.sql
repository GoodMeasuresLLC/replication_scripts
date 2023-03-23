CREATE SUBSCRIPTION public
  CONNECTION 'host=172.16.7.125 port=5432 dbname=code_staging' PUBLICATION public
  WITH(copy_data=TRUE);
