#!/bin/sh
set -e

# Create runtime directory (cleared on container restart)
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize database if not exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null
    
    # Start temporary server
    mysqld --user=mysql --skip-networking &
    
    # Wait for socket creation
    while [ ! -S /run/mysqld/mysqld.sock ]; do sleep 1; done

    # Basic security setup
    mysql <<-EOSQL
        CREATE DATABASE ${DB_NAME:-mydatabase};
        CREATE USER '${DB_USER:-user}'@'%' IDENTIFIED BY '${DB_PASSWORD:-password}';
        GRANT ALL ON ${DB_NAME:-mydatabase}.* TO '${DB_USER:-user}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD:-rootpass}';
        FLUSH PRIVILEGES;
EOSQL

    # Clean shutdown
    killall -TERM mysqld
    while [ -S /run/mysqld/mysqld.sock ]; do sleep 1; done
fi

# Start main process
exec mysqld --user=mysql