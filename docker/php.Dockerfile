FROM php:8.1.1-fpm


RUN apt-get update && apt-get install -y \
        curl \
        wget \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libjpeg-dev \
        libjpeg62-turbo-dev \
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
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gettext iconv mbstring mysqli pdo_mysql zip bcmath fileinfo curl opcache phar session soap sockets gd \
	&& pecl install memcached \
	&& pecl install imagick \
	&& docker-php-ext-enable memcached \
	&& docker-php-ext-enable imagick

# Install GD
#RUN apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev libzip-dev zlib-dev
#RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
#RUN docker-php-ext-install gd
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg

#RUN docker-php-ext-configure gd --with-png=/usr/include/ --with-jpeg=/usr/include/ --with-freetype=/usr/include/

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/
#
COPY ./config/php /usr/local/etc/php


#RUN chmod 0644 /etc/cron.d/maincron

## Apply cron job
#RUN crontab /etc/cron.d/maincron

# Create the log file to be able to run tail
#RUN touch /var/log/cron.log

# Run the command on container startup
#CMD cron && tail -f /var/log/cron.log