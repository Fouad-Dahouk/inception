FROM debian:bookworm

# Install MariaDB server
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Only keep build-time config (remove directory creation)
RUN echo "[mysqld]\nsocket=/run/mysqld/mysqld.sock" >> /etc/mysql/my.cnf

# Copy entrypoint script
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/tmp/entrypoint.sh"]