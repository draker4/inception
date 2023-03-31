FROM debian:stable-20230320-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	nodejs \
	&& apt-get clean \
	&& rm -rf /var/apt/list/*

COPY ./tools /

EXPOSE 1212

CMD ["node", "server.js"]
