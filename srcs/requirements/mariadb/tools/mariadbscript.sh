#!/bin/bash
set -e

if [ -d "/var/lib/mysql/${MYSQL_DATABASE}" ]

then
    echo "${MYSQL_DATABASE} already exists\n"

else 
    # Start MariaDB service
    service mariadb start

    # Wait for MariaDB to start
    sleep 10

    # Log into MariaDB as root and execute SQL commands
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    sleep 1

    # Stop MariaDB service
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
    sleep 1

    # Print status
    echo "MariaDB database and user were created successfully!"

fi
# Start MariaDB in the foreground
exec mysqld_safe