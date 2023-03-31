FROM debian:stable-20230320-slim

RUN apt-get update && apt-get install -y \
	mariadb-client \
	php7.4-fpm \
	php-mysql \
	php-curl \
	php-dom \
	php-imagick \
	php-mbstring \
	php-zip \
	php-gd \
	php-intl \
	curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /run/php /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/

COPY ./tools/start_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_wp.sh
ENTRYPOINT ["/usr/local/bin/start_wp.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
