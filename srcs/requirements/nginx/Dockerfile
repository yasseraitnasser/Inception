FROM debian:bookworm

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    nginx openssl && rm -rf /var/lib/apt/lists/*

COPY nginx_init.sh /etc/

RUN chmod +x /etc/nginx_init.sh
RUN /etc/nginx_init.sh

COPY nginx.conf /etc/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
