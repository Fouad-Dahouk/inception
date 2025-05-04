FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Create SSL directory
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 \
    -subj "/C=LB/ST=Beirut/L=Beirut/O=42/CN=${DOMAIN_NAME}" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt

# Copy custom Nginx configuration
COPY ./tools/nginx.conf /etc/nginx/sites-available/default

# Expose HTTPS port
EXPOSE 443

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]