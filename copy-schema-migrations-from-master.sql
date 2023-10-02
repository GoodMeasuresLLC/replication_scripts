-- execute this once to set up
create extension postgres_fdw;
CREATE SERVER master_db
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host '172.16.1.79', dbname 'code_production', port '5432');
CREATE USER MAPPING FOR postgres
SERVER master_db OPTIONS (user 'postgres');
create schema master_db_schema;
IMPORT FOREIGN SCHEMA schema
FROM SERVER master_db INTO master_db_schema;
-- execute every time.
insert into schema.schema_migrations(version) select version from master_db_schema.schema_migrations;
