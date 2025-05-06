#!/bin/sh

# Initialize MariaDB if the data directory is not already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

    # Start MariaDB temporarily as mysql user
    mysqld_safe --datadir=/var/lib/mysql --user=mysql &

    # Wait until MariaDB is fully initialized (using mysqladmin to ping)
    until mysqladmin ping --silent; do
        echo "Waiting for MariaDB to be ready..."
        sleep 2
    done

    # Create database, user, and set privileges
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    # Shut down MariaDB temporarily
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

# Start MariaDB as mysql user (required)
exec mysqld --user=mysql
