FROM debian:bookworm

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    nginx openssl && rm -rf /var/lib/apt/lists/*

COPY ssl/certs/server.crt /etc/ssl/certs/server.crt
COPY ssl/private/server.key /etc/ssl/private/server.key
COPY nginx.conf /etc/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
