FROM php:7-alpine

FROM php:7.0-alpine

RUN apk add --update \
  coreutils \
  freetype-dev \
  libjpeg-turbo-dev \
  libltdl \
  libmcrypt-dev \
  libpng-dev \
  build-base \
  git \
  curl \
  unzip \
  icu \
  icu-libs \
  icu-dev \
  libxml2-dev \
  libxslt-dev \
  && rm -rf /var/cache/apk/* \
#
# RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
#   && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'c32408bcd017c577ce80605420e5987ce947a5609e8443dd72cd3867cc3a0cf442e5bf4edddbcbe72246a953a6c48e21') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
#   && php composer-setup.php --filename=composer --install-dir=/usr/local/bin \
#   && php -r "unlink('composer-setup.php');"
#
#
# RUN apt-get -y update \
#  && apt-get -y install git-core \
#                        unzip \
#                        zlib1g-dev \
#                        libicu-dev \
#                        g++ \
#                        libxslt-dev \
#                        libxml2-dev \
#                        libfreetype6-dev \
#                        libjpeg62-turbo-dev \
#                        libmcrypt-dev \
#                        libpng12-dev \
 && docker-php-ext-install -j$(nproc) iconv mcrypt \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd \
 && docker-php-ext-configure intl \
 && docker-php-ext-install intl \
 && docker-php-ext-configure exif \
 && docker-php-ext-install exif \
 && docker-php-ext-install pdo pdo_mysql \
 && docker-php-ext-configure xsl \
 && docker-php-ext-install xsl \
 && docker-php-ext-configure zip \
 && docker-php-ext-install zip \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./src /app
WORKDIR /app

RUN composer install --no-interaction

EXPOSE 80
