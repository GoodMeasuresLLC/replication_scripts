CREATE SUBSCRIPTION public
  CONNECTION 'host=172.16.1.51 port=5432 dbname=code_production' PUBLICATION public
  WITH(copy_data=FALSE);
