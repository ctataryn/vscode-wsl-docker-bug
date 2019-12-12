FROM php:7.3-apache

ARG APP_ENV=production

ENV DEBIAN_FRONTEND noninteractive

RUN echo "*\n* Environment: ${APP_ENV}\n*"

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get upgrade -y && \
    apt-get install -y zip unzip libzip-dev wget && \
    apt-get autoremove -y && \
    apt-get clean && rm -r /var/lib/apt/lists/*

# @todo Do we need pdo_mysql? A: Laravel does not start without it
RUN docker-php-ext-install pdo_mysql zip bcmath
RUN a2enmod rewrite
COPY .docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN test "$APP_ENV" = "production" && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" || \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /opt/bin:/root/.composer/vendor/bin:${PATH}
RUN mkdir -p /opt/bin && \
    curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/opt/bin --filename=composer

# Add source code as root since application should not modify it
COPY . /var/www/html
COPY .docker/start.sh /usr/local/bin/start

WORKDIR /var/www/html

RUN ./.docker/build.sh
RUN chmod u+x /usr/local/bin/start

CMD ["/usr/local/bin/start"]
