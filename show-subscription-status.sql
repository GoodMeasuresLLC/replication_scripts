select pglogical.show_subscription_status('public');

-- state will be "streaming" if it is working right.
-- run this command on the publisher
select client_addr, state from pg_stat_replication where state = 'streaming';
-- or to detect a problem:
select client_addr, state from pg_stat_replication where state <> 'streaming';

-- this gives replication delay
select last_msg_receipt_time - last_msg_send_time  as replication_delay from pg_stat_subscription;

-- this gives subscription configuration
select subenabled, subconninfo from pg_subscription;

-- this gives detailed status by table
-- State code: i = initialize,
--   d = data is being copied,
--   f = finished table copy,
--    s = synchronized,
--     r = ready (normal replication)
select * from pg_subscription_rel where srsubstate != 'r';
select srrelid::regclass, * from pg_subscription_rel;

or 

select relname, srsubstate from pg_subscription_rel join pg_class on oid = srrelid;




---
code_staging=# select * from pg_publication;
  oid  | pubname | pubowner | puballtables | pubinsert | pubupdate | pubdelete | pubtruncate | pubviaroot
-------+---------+----------+--------------+-----------+-----------+-----------+-------------+------------
 62917 | public  |       10 | f            | t         | t         | t         | t           | f

-- check if a table has been added to publication set
select * from pg_publication_tables where tablename = 'blergs';

-- get the next sequence number for a given table
SELECT nextval(pg_get_serial_sequence('blergs', 'id'));
SELECT nextval(pg_get_serial_sequence('users', 'id'));


--- alarms:

SELECT slot_name, slot_type,
SELECT slot_name, active, pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn) FROM pg_replication_slots;
