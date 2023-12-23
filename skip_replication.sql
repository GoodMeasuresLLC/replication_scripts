 -- get the lsn from the /var/log/syslog error message
 ALTER SUBSCRIPTION public SKIP (lsn = 'F4/DAABEED0');


-- you can find the latest LSN on the reporting db (the subscriber) by doing
select pg_current_wal_lsn();
-- which gives: 6FC/93BA5F80
-- and then you can skip past 6FC/93BA5F80 by doing
-- 6FC/93BA5F80+1 = 6FC/93BA5F81
-- and on the reporting db (the subscriber)
ALTER SUBSCRIPTION public SKIP (lsn = '6FC/93BA5F81');
