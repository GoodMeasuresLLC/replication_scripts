sudo su postgres
rm -rf /mnt/postgresql/15/pgdata
cd /usr/lib/postgresql/15/bin
./initdb /mnt/postgresql/15/pgdata
service postgresql start
