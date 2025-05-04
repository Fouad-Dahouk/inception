FROM debian:bookworm

# Install MariaDB server
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Ensure the socket directory exists and has correct permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Configure MariaDB to use the correct socket path
RUN echo "[mysqld]\nsocket=/run/mysqld/mysqld.sock" >> /etc/mysql/my.cnf

# Copy entrypoint script
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose MySQL port
EXPOSE 3306

# Set entrypoint
ENTRYPOINT ["entrypoint.sh"]
