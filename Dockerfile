FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV HUB_VERSION=1.0.529 \
    JAVA_HOME=/usr/lib/jvm/java-1.7-openjdk \
    TIMEZONE=Europe/Warsaw

RUN apk --update add openjdk7-jre-base openssl unzip tzdata\
    && wget -O /tmp/hub-ring.zip http://download.jetbrains.com/hub/1.0/hub-ring-bundle-$HUB_VERSION.zip \
    && mkdir -p /opt/hub \
    && unzip /tmp/hub-ring.zip -d /opt/hub  \
    && rm -rf /tmp/hub-ring.zip  /var/cache/apk/* \
    && cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo "$TIMEZONE" >  /etc/timezone

EXPOSE 8080
VOLUME ["/opt/hub/conf", "/opt/hub/data"]
ENTRYPOINT ["/opt/hub/bin/hub.sh", "run"]
CMD [""]
