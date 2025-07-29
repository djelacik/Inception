FROM debian:bullseye

# Install nginx and openssl
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Copy configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default /etc/nginx/sites-available/default
COPY tools/setup_nginx.sh /usr/local/bin/setup_nginx.sh

# Make script executable
RUN chmod +x /usr/local/bin/setup_nginx.sh

# Remove default nginx website
RUN rm -rf /var/www/html/*

# Expose HTTPS port
EXPOSE 443

# Run setup script
ENTRYPOINT ["/usr/local/bin/setup_nginx.sh"]
