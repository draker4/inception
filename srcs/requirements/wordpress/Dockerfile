FROM debian:latest

RUN apt-get update && apt-get install -y \
	mariadb-client \
	php-mysql \
	php7.4-fpm \
	curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /run/php /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data /var/www/html \
	&& chmod -R 755 /var/www/html

WORKDIR /var/www/html/

COPY ./tools/start_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_wp.sh
ENTRYPOINT ["/usr/local/bin/start_wp.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
