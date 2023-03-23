-- list all tables in a publication
select * from pg_publication_tables where tablename ilike '%schema%';
