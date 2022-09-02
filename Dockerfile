# Composer builder
#FROM composer as builder
#

# PHP 7.4 FPM
FROM php:8.0-fpm

WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev

# Clear cache
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
#RUN docker-php-ext-install pdo_mysql zip exif pcntl
#RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#RUN docker-php-ext-install pdo_mysql mbstring

WORKDIR /app
COPY composer.json .
RUN composer install --no-scripts
COPY . .
EXPOSE 80

CMD php artisan serve --host=0.0.0.0 --port 80
