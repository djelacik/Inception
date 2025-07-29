#!/bin/bash

cd /var/www/html

# Wait for MariaDB to be ready
while ! mysql -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Download and setup WP-CLI
if [ ! -f wp-cli.phar ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
fi

# Download WordPress if not exists
if [ ! -f wp-config.php ]; then
    echo "Setting up WordPress..."
    
    ./wp-cli.phar core download --allow-root
    
    ./wp-cli.phar config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=${MYSQL_HOST} \
        --allow-root
    
    ./wp-cli.phar core install \
        --url=https://${DOMAIN_NAME} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root
    
    # Create additional user
    ./wp-cli.phar user create \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author \
        --allow-root
        
    echo "WordPress setup completed!"
fi

# Change ownership
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
exec php-fpm7.4 -F
