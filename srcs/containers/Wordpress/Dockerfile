FROM debian:bookworm

# Install PHP, FPM, and necessary packages
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql curl wget unzip mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Download and extract WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rm -rf wordpress

# Set working directory
WORKDIR /var/www/html

# Copy entrypoint script
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose PHP-FPM port (optional, for debugging or other layers)
EXPOSE 9000

# Entrypoint
ENTRYPOINT ["entrypoint.sh"]
