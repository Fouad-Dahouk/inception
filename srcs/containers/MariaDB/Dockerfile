FROM debian:bookworm

# Install MariaDB server
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy entrypoint script
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose MySQL port
EXPOSE 3306

# Set entrypoint
ENTRYPOINT ["entrypoint.sh"]
