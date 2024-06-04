#!/bin/bash

# Wait for 10 seconds to ensure everything is ready
sleep 10

mkdir -p /run/php/
chown www-data:www-data /run/php/
cd /var/www/html

if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress is already set up!"
else
	 sleep 10

    wp core download --allow-root
						--path='/var/www/html'
	wp config create --allow-root \
						--dbname=$MYSQL_DATABASE \
						--dbuser=$MYSQL_USER \
						--dbpass=$MYSQL_PASSWORD \
						--dbhost=$MYSQL_HOSTNAME \
						--path='/var/www/html'
	chmod 777 /var/www/html/wp-config.php
	 wp core install --allow-root \
	 					--url=$DOMAIN_NAME \
	 					--title="$TITLE" \
	 					--admin_user=$WP_ADMIN_USER \
	 					--admin_password=$WP_PASSWORD \
	 					--admin_email=$WP_ADMIN_MAIL \
	 					--path='/var/www/html'
	wp user create $WP_SECOND_USER $WP_SECOND_USER_MAIL \
						--allow-root \
						--role=author \
						--user_pass=$WP_SECOND_USER_PW \
						--path='/var/www/html'
	chown -R root:root /var/www/html
    
    echo "WordPress is running!"
fi
exec /usr/sbin/php-fpm7.4 -F -R