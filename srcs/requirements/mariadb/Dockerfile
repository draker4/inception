FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/apt/list/*

RUN mkdir -p /var/run/mysql \
	&& chown -R mysql:mysql /var/run/mysql

COPY tools/start_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_db.sh
ENTRYPOINT ["/usr/local/bin/start_db.sh"]

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]
