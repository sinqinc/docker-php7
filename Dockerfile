FROM php:7-fpm

RUN apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev zlib1g-dev bzip2 libicu-dev libxslt1-dev libbz2-dev libxml2-dev mcrypt libcurl4-openssl-dev && docker-php-ext-install iconv mcrypt && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd && docker-php-ext-install mbstring && docker-php-ext-install zip && docker-php-ext-install pdo pdo_mysql && docker-php-ext-install bz2 && docker-php-ext-install curl && docker-php-ext-install mysqli && docker-php-ext-install gettext && docker-php-ext-install calendar && docker-php-ext-install intl && docker-php-ext-install xsl 



RUN apt-get install -y php-pear curl zlib1g-dev libncurses5-dev

RUN apt-get update && apt-get install -y libldap2-dev
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap


CMD ["php", "-a"]
