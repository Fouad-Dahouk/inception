FROM debian:bookworm

# Install Nginx and OpenSSL
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Create SSL certs directory
RUN mkdir -p /etc/ssl/private /etc/ssl/certs

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=LB/ST=Beirut/L=Beirut/O=42/CN=fdahouk.42.fr"

# Copy custom Nginx config
COPY ./tools/nginx.conf /etc/nginx/sites-available/default

# Expose port 443 for HTTPS
EXPOSE 443

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
