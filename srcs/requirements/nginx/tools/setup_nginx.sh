#!/bin/bash

# Generate SSL certificate if it doesn't exist
if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    echo "Generating SSL certificate..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=42Helsinki/OU=Student/CN=${DOMAIN_NAME}"
fi

# Test nginx configuration
nginx -t

# Start nginx in foreground
exec nginx -g "daemon off;"
