FROM tetraweb/php:7.1
MAINTAINER Luc Calaresu <dev@calaresu.com>

WORKDIR /tmp

RUN apt-get update \
    && apt-get install -y bash \
        ca-certificates \
        git \
        mercurial \
        curl \
        wget \
        openssl \
        rsync \
        docker-ce \
        unzip \
        libxml2-utils \
        gcc \
        make 

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD ["--help"]
