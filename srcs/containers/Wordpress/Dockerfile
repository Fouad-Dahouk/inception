FROM debian:bookworm

# Install PHP, PHP-FPM, and WordPress dependencies
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql curl wget unzip mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Ensure PHP-FPM listens on 0.0.0.0:9000
RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/*/fpm/pool.d/www.conf

# Download and extract WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mkdir -p /var/www/html && \
    mv wordpress/* /var/www/html

# Copy entrypoint script
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set working directory
WORKDIR /var/www/html

# Expose PHP-FPM port
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
