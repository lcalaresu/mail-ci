FROM alpine:latest
MAINTAINER Luc Calaresu <dev@calaresu.com>

WORKDIR /tmp

RUN apk --no-cache add  \
        bash \
        ca-certificates \
        git \
        mercurial \
        curl \
        wget \
        openssl \
        rsync \
        docker \
        unzip \
        libxml2-utils \
        php7 php7-xml \
        php7-exif \
        php7-zip \
        php7-xmlreader \
        php7-zlib \
        php7-opcache \
        php7-mcrypt \
        php7-openssl \
        php7-curl \
        php7-json \
        php7-dom \
        php7-phar \
        php7-mbstring \
        php7-bcmath \
        php7-pdo \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-pdo_mysql \
        php7-soap \
        php7-xdebug \
        php7-pcntl \
        php7-ctype \
        php7-session \
        php7-tokenizer \
    && php -r "copy('https://phar.phpunit.de/phpunit-5.7.phar', '/usr/bin/phpunit');" \
    && chmod +x /usr/bin/phpunit \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"  \ 
    # Enable X-Debug
    && sed -i 's/\;z/z/g' /etc/php7/conf.d/xdebug.ini \
    && php -m | grep -i xdebug

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD ["--help"]
