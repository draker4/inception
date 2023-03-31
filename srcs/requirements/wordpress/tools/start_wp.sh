#!/bin/sh

set -xv

#chown -R www-data:www-data /var/www/html
#chmod -R 777 /var/www/html

if [ -f ./wp-config.php ]
then
	echo "wordpress well installed"
else

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

	########## REDIS (BONUS) ##########

	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	cp ./wp-content/plugins/redis-cache/includes/object-cache.php ./wp-content/

	######### END BONUS PART  #########
fi

chown -R www-data:www-data /var/www/html/
chmod 777 /var/www/html/
chmod 777 /var/www/html/wp-content
chmod 777 /var/www/html/wp-content/plugins/

wp redis enable --force --allow-root

exec "$@"
