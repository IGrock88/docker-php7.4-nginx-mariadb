FROM php:8.1.1-fpm

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
		libmemcached-dev \
		memcached \
		zlib1g-dev \
		zip \
		cron \
		libonig-dev \
		libzip-dev \
		libssl-dev \
		libcurl4-openssl-dev \
		libxml2-dev \
		libmagickwand-dev \
    && docker-php-ext-install -j$(nproc) gettext iconv mbstring mysqli pdo_mysql zip bcmath curl opcache phar session soap sockets zip \
	&& pecl install memcached \
	&& pecl install imagick \
	&& docker-php-ext-enable memcached \
	&& docker-php-ext-enable imagick

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/

COPY ./config/php /usr/local/etc/php

#RUN chmod 0644 /etc/cron.d/maincron

## Apply cron job
#RUN crontab /etc/cron.d/maincron

# Create the log file to be able to run tail
#RUN touch /var/log/cron.log

# Run the command on container startup
#CMD cron && tail -f /var/log/cron.log