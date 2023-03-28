#!/bin/sh

set -xv

wp core download --allow-root

until mysqladmin -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD ping \
	&& mariadb -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" \
	| grep "$MYSQL_DATABASE"; \
	do
	sleep 1
done

wp core config --dbhost=$MYSQL_HOSTNAME --dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --allow-root

wp core install --url=$DOMAIN_NAME --title="Hello You" \
	--admin_name=$WP_ADMIN --admin_password=$WP_ADMIN_PASS \
	--admin_email=$WP_ADMIN_EMAIL --allow-root

wp user create $WP_USER $WP_USER_EMAIL --role=subscriber \
	--user_pass=$WP_USER_PASS --display_name=$WP_USER_DISPLAY --allow-root

exec "$@"
