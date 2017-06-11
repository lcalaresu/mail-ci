FROM tetraweb/php:7.1
MAINTAINER Luc Calaresu <dev@calaresu.com>

WORKDIR /tmp

RUN apt-get update \
  && apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
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
        make \
        libpng-dev 

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

# override phpunit and put binary into $PATH
RUN curl -sSLo phpunit.phar https://phar.phpunit.de/phpunit-5.7.phar \
    && chmod 755 phpunit.phar \
    && mv phpunit.phar /usr/local/bin/ 

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD ["--help"]
