FROM alpine:latest
MAINTAINER Andre Pollard ap2516@att.com

RUN apk update && \
	apk add mysql mysql-client && \
	addgroup mysql mysql && \
	mkdir /scripts && \
	rm -rf /var/cache/apk/*

VOLUME ["/var/lib/mysql"]

COPY ./config/my.cnf /etc/mysql/my.cnf
COPY ./scripts/startup.sh /scripts/startup.sh
RUN chmod +x /scripts/startup.sh

EXPOSE 3306

ENTRYPOINT ["/scripts/startup.sh"]


