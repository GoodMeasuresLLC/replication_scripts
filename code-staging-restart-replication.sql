SELECT pglogical.create_subscription(
  subscription_name := 'public',
provider_dsn :=  'host=172.16.7.93 port=5432 dbname=code_staging user=postgres',
replication_sets := '{public}',
synchronize_data := FALSE
);
