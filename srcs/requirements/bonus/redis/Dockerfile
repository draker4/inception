FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	redis \
	&& apt-get clean \
	&& rm -rf /var/apt/list/*

COPY ./tools/redis.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/redis.sh

EXPOSE 

CMD ["/usr/local/bin/redis.sh"]
