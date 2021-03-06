FROM mkimberley84/centos-nginx:latest
MAINTAINER Matt Kimberley <matt.kimberley84@gmail.com>

ENV GENERICCACHE_VERSION 1
ENV WEBUSER nginx
ENV CACHE_MEM_SIZE 500m
ENV CACHE_DISK_SIZE 500000m
ENV CACHE_MAX_AGE 60d

COPY overlay/ /

RUN	chmod 755 /scripts/*			;\
	mkdir -m 755 -p /data/cache		;\
	mkdir -m 755 -p /data/info		;\
	mkdir -m 755 -p /data/logs		;\
	mkdir -m 755 -p /tmp/nginx/		;\
	chown -R ${WEBUSER}:${WEBUSER} /data/	;\
	mkdir -p /etc/nginx/sites-enabled	;\
	ln -s /etc/nginx/sites-available/generic.conf /etc/nginx/sites-enabled/generic.conf

VOLUME ["/data/logs", "/data/cache", "/var/www"]

EXPOSE 80

WORKDIR /scripts

ENTRYPOINT ["/scripts/bootstrap.sh"]
