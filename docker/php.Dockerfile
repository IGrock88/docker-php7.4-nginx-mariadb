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

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/

RUN apt-get update && apt-get install -y gnupg2
RUN apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get -y install google-chrome-stable

#COPY ./etc/crons/php/cronfile /etc/cron.d/maincron

#RUN chmod 0644 /etc/cron.d/maincron

## Apply cron job
#RUN crontab /etc/cron.d/maincron

# Create the log file to be able to run tail
#RUN touch /var/log/cron.log

# Run the command on container startup
#CMD cron && tail -f /var/log/cron.log
