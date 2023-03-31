FROM debian:stable-20230320-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	curl \
	&& apt-get clean \
	&& rm -rf /var/apt/list/*

RUN curl -LO https://github.com/google/cadvisor/releases/download/v0.39.0/cadvisor \
    && chmod +x /cadvisor

EXPOSE 8585

CMD ["/cadvisor", "--port=8585"]
