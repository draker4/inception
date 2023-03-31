FROM debian:stable-20230320-slim

RUN apt-get update && apt upgrade -y && apt-get install -y \
	ftp \
	vsftpd \
	&& apt-get clean \
	&& rm -rf /var/apt/list/*

COPY tools/server-ftp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/server-ftp.sh
ENTRYPOINT ["/usr/local/bin/server-ftp.sh"]

EXPOSE 21 40000-40009

CMD ["vsftpd", "/etc/vsftpd.conf"]
