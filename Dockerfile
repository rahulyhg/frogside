FROM php:7.0-alpine

RUN apk add --update \
  build-base \
  git \
  && rm -rf /var/cache/apk/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'c32408bcd017c577ce80605420e5987ce947a5609e8443dd72cd3867cc3a0cf442e5bf4edddbcbe72246a953a6c48e21') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --filename=composer --install-dir=/usr/local/bin \
  && php -r "unlink('composer-setup.php');"

COPY ./ /app

RUN rm -rf /app/client

WORKDIR /app

RUN composer install

EXPOSE 7000
