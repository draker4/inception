FROM debian:stable-20230320-slim

RUN apt-get update && apt-get install -y \
    redis \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 6379

CMD ["redis-server", "--bind 0.0.0.0", "--maxmemory 20mb", "--maxmemory-policy allkeys-lfu", "--protected-mode no", "--dir /data", "--save 60 1"]
