FROM coolsoft/jdk8:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV HUB_VERSION=1.0.529 \
    TIMEZONE=Europe/Warsaw

RUN apk --update add openssl unzip tzdata\
    && wget -O /tmp/hub-ring.zip http://download.jetbrains.com/hub/1.0/hub-ring-bundle-$HUB_VERSION.zip \
    && mkdir -p /opt/hub \
    && unzip /tmp/hub-ring.zip -d /opt/hub  \
    && rm -rf /tmp/hub-ring.zip  /var/cache/apk/* \
    && cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo "$TIMEZONE" >  /etc/timezone

EXPOSE 8080
VOLUME ["/opt/hub/conf", "/opt/hub/data"]
CMD ["/opt/hub/bin/hub.sh", "run"]

