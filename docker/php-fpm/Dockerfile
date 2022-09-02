# Composer builder
#FROM composer as builder
#

# PHP 7.4 FPM
FROM php:7.4-fpm

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
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY composer.lock composer.json /var/www/
WORKDIR /var/www

# Copy existing application directory contents
COPY . /var/www

RUN composer install --no-plugins --no-scripts

# Copy vendor directory contents from builder stage
#COPY --from=builder /var/www/vendor /var/www/vendor

# Generate Laravel app key
RUN cp .env.example .env
#RUN php artisan key:generate

# Generate Swagger documentation
#RUN php artisan l5-swagger:generate

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
RUN chown -R www:www /var/www/vendor
# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
