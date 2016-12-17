FROM php:7.0-alpine

RUN apk add --update \
  build-base \
  git \
  && rm -rf /var/cache/apk/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --filename=composer --install-dir=/usr/local/bin \
  && php -r "unlink('composer-setup.php');"

COPY ./ /app

WORKDIR /app

RUN composer install

EXPOSE 7000
