select pglogical.alter_subscription_disable('public');
select pglogical.alter_subscription_enable('public');

-- builtin

ALTER SUBSCRIPTION public DISABLE
ALTER SUBSCRIPTION public ENABLE

bundle exec cap staging console
find /mnt/code/releases -prune -ctime +1 | xargs rm -rf
