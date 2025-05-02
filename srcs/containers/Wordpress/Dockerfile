FROM debian:bullseye

# Install PHP, PHP-FPM, and WordPress dependencies
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql curl wget unzip mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Download WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html

# Copy entrypoint
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose PHP-FPM port
EXPOSE 9000

# Set working dir
WORKDIR /var/www/html

# Set entrypoint
ENTRYPOINT ["entrypoint.sh"]
