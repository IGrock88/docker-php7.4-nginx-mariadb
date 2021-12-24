FROM nginx:latest


RUN apt -y install lsb-release apt-transport-https ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list



RUN apt-get update && apt -y install php8.1.1 && apt-get install -y \
        nginx php8.1.1-fpm \
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
    && docker-php-ext-install -j$(nproc) gettext iconv mbstring mysqli pdo_mysql zip bcmath curl json opcache phar session soap sockets zip \
	&& pecl install memcached \
	&& pecl install imagick \
	&& docker-php-ext-enable memcached \
	&& docker-php-ext-enable imagick

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/