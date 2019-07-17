FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
	zlib1g-dev \
	bzip2 \
	libicu-dev \
	libxslt1-dev \
	libbz2-dev \
	libxml2-dev \
	mcrypt \
	libpq-dev \
	libcurl4-openssl-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
   && docker-php-ext-install mbstring \
   && docker-php-ext-install zip \
   && docker-php-ext-install pdo pdo_mysql \
   && docker-php-ext-install bz2 \
   && docker-php-ext-install curl \
   && docker-php-ext-install mysqli \
   && docker-php-ext-install gettext \
   && docker-php-ext-install calendar \
   && docker-php-ext-install intl \
   && docker-php-ext-install xsl \
   && docker-php-ext-install xml \
   && docker-php-ext-install tokenizer \
	&& docker-php-ext-install pgsql

RUN apt-get install -y \
php-pear curl zlib1g-dev libncurses5-dev

RUN apt-get install -y libxml2-dev && \
    docker-php-ext-install soap

#RUN curl -L http://pecl.php.net/get/memcache-2.2.7.tgz >> /usr/src/php/ext/memcache.tgz && \
#tar -xf /usr/src/php/ext/memcache.tgz -C /usr/src/php/ext/ && \
#rm /usr/src/php/ext/memcache.tgz && \
#docker-php-ext-install memcache-2.2.7

#RUN apt-get install -y \
#php-pear curl libmemcached-dev zlib1g-dev libncurses5-dev

#RUN curl -L http://pecl.php.net/get/memcached-2.2.0.tgz >> /usr/src/php/ext/memcached.tgz && \
#tar -xf /usr/src/php/ext/memcached.tgz -C /usr/src/php/ext/ && \
#rm /usr/src/php/ext/memcached.tgz && \
#docker-php-ext-install memcached-2.2.0

# Download and Installing php libraries 
RUN apt-get -y install php-pear php5-dev 

# Download and Installing git and vim 
RUN apt-get -y install git vim gcc

# Download and Installing zip unzip 
RUN apt-get -y install zip unzip 

# install PHP PEAR extensions 
RUN apt-get -y install wget 

RUN apt-get -y install libmemcached-dev libmemcached11
WORKDIR /tmp
RUN git clone https://github.com/php-memcached-dev/php-memcached && cd php-memcached && git checkout -b php7 origin/php7 && phpize && ./configure && make && make install
#WORKDIR /tmp/php-memcached
#RUN /usr/bin/phpize 
#RUN ./configure && make && make install

RUN apt-get install -y memcached 

RUN apt-get install -y php-pear curl zlib1g-dev libncurses5-dev

RUN apt-get update && apt-get install -y libldap2-dev
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap

ENV PHPREDIS_VERSION php7

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/master.tar.gz  \
    && mkdir /tmp/redis \
    && tar -xf /tmp/redis.tar.gz -C /tmp/redis \
    && rm /tmp/redis.tar.gz \
    && ( \
    cd /tmp/redis/phpredis-master \
    && phpize \
        && ./configure \
    && make -j$(nproc) \
        && make install \
    ) \
    && rm -r /tmp/redis \
    && docker-php-ext-enable redis

# Install opcache
RUN docker-php-ext-install opcache

# Install APCu
RUN pecl install apcu


EXPOSE 9000
CMD ["php-fpm"]
