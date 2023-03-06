sudo su postgres
createdb code_staging
createuser tableau_postgres
createdb canvas_staging
createuser ubuntu
psql canvas_staging < ~/canvas_schema.sql
psql code_staging < ~/schema.sql
