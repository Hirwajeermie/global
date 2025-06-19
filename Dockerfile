# Use official PHP 8.1 Apache image
FROM php:8.1-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Install system dependencies and PHP extensions as needed (example: mysqli, pdo, zip, gd)
RUN apt-get update && \
    apt-get install -y libzip-dev unzip && \
    docker-php-ext-install mysqli pdo pdo_mysql zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy composer files first for better build caching
COPY src/composer.json src/composer.lock* /var/www/html/
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader; fi

# Copy the rest of the application code
COPY src/ /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose Apache port
EXPOSE 80