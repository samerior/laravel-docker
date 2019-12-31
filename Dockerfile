# Alpine Image for Nginx and PHP

# NGINX x ALPINE.
FROM nginx:1.17-alpine

# MAINTAINER OF THE PACKAGE.
LABEL maintainer="Samerior Group <info@samerior.com>"

# INSTALL SOME SYSTEM PACKAGES.
RUN apk --update --no-cache add ca-certificates \
    bash \
    supervisor

# trust this project public key to trust the packages.
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# IMAGE ARGUMENTS WITH DEFAULTS.
ARG PHP_VERSION=7.4
ARG ALPINE_VERSION=3.10
ARG NGINX_HTTP_PORT=80
ARG NGINX_HTTPS_PORT=443

# CONFIGURE ALPINE REPOSITORIES AND PHP BUILD DIR.
RUN echo "https://dl.bintray.com/php-alpine/v${ALPINE_VERSION}/php-${PHP_VERSION}" >> /etc/apk/repositories


# INSTALL PHP AND SOME EXTENSIONS. SEE: https://github.com/codecasts/php-alpine
RUN apk add --no-cache --update php-fpm \
    php \
    php-openssl \
    php-pdo \
    php-pdo_mysql \
    php-mbstring \
    php-phar \
    php-session \
    php-dom \
    php-curl \
    php-ctype \
    php-zlib \
    php-json \
    php-xml && \
    ln -s /usr/bin/php7 /usr/bin/php

# CONFIGURE WEB SERVER.
RUN mkdir -p /var/www && \
    mkdir -p /run/php && \
    mkdir -p /run/nginx && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /etc/nginx/sites-enabled && \
    mkdir -p /etc/nginx/sites-available && \
    rm /etc/nginx/nginx.conf && \
    rm /etc/php7/php-fpm.d/www.conf && \
    rm /etc/php7/php.ini

# INSTALL COMPOSER.
ADD config/composer/setup.sh /usr/bin/composer-setup.sh
RUN chmod +x /usr/bin/composer-setup.sh
RUN /usr/bin/composer-setup.sh

# ADD START SCRIPT, SUPERVISOR CONFIG, NGINX CONFIG AND RUN SCRIPTS.
ADD entrypoint.sh /entrypoint.sh
ADD config/supervisor/supervisord.conf /etc/supervisord.conf
ADD config/nginx/nginx.conf /etc/nginx/nginx.conf
ADD config/nginx/site.conf /etc/nginx/sites-available/default.conf
ADD config/php/php.ini /etc/php7/php.ini
ADD config/php-fpm/www.conf /etc/php7/php-fpm.d/www.conf
RUN chmod 755 /entrypoint.sh

# EXPOSE PORTS!
EXPOSE ${NGINX_HTTPS_PORT} ${NGINX_HTTP_PORT}

# SET THE WORK DIRECTORY.
WORKDIR /var/www

# KICKSTART!
CMD ["/entrypoint.sh"]