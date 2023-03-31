FROM debian:stable-20230320-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    ca-certificates \
    php7.4 \
    php7.4-cli \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    php7.4-gd \
    php7.4-curl \
    php7.4-mysql \
    php7.4-sqlite3 \
    php7.4-pgsql \
	&& apt-get clean \
	&& rm -rf /var/apt/list/*

RUN mkdir /usr/share/adminer && \
    wget "https://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php \
    && ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php \
    && echo "<?php header('Location: /adminer.php'); ?>" > /usr/share/adminer/index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/usr/share/adminer"]
