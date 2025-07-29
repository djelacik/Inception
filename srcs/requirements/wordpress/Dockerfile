FROM debian:bullseye

# Install PHP-FPM and required packages
RUN apt-get update && \
    apt-get install -y \
        php7.4-fpm \
        php7.4-mysql \
        php7.4-curl \
        php7.4-gd \
        php7.4-mbstring \
        php7.4-xml \
        php7.4-zip \
        curl \
        wget \
        mariadb-client \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir -p /var/www/html /run/php

# Copy configuration files
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/setup_wordpress.sh /usr/local/bin/setup_wordpress.sh

# Make script executable
RUN chmod +x /usr/local/bin/setup_wordpress.sh

# Change ownership
RUN chown -R www-data:www-data /var/www/html

# Expose PHP-FPM port
EXPOSE 9000

# Run setup script
ENTRYPOINT ["/usr/local/bin/setup_wordpress.sh"]
