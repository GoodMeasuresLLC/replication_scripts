-- move schema migrations
CREATE SCHEMA schema;
CREATE TABLE schema.schema_migrations AS select * from public.schema_migrations;
