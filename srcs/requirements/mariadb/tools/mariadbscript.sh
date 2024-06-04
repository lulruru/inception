#!/bin/bash
set -e

if [ -d "/var/lib/mysql/${SQL_DATABASE}" ]

then
    echo "${SQL_DATABASE} already exists\n"

else 
    # Start MariaDB service
    service mariadb start

    # Wait for MariaDB to start
    sleep 10

    # Log into MariaDB as root and execute SQL commands
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${mySQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${mySQL_USER}\`@'localhost' IDENTIFIED BY '${mySQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${mySQL_DATABASE}\`.* TO \`${mySQL_USER}\`@'%' IDENTIFIED BY '${mySQL_PASSWORD}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${mySQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    sleep 1

    # Stop MariaDB service
    mysqladmin -u root -p${mySQL_ROOT_PASSWORD} shutdown
    sleep 1

    # Print status
    echo "MariaDB database and user were created successfully!"

fi
# Start MariaDB in the foreground
exec mysqld