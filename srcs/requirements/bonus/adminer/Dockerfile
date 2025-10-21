# FROM debian:bookworm

# RUN apt-get update -y && apt-get install -y --no-install-recommends \
#     php \
#     php-mysqli \
#     php-pgsql \
#     php-sqlite3 \
#     php-json \
#     wget \
#     && rm -rf /var/lib/apt/lists/* \
#     && mkdir -p /var/www/html

FROM alpine:3.21

RUN apk add --no-cache wget php php-session php-mysqli &&\
    mkdir /var/www

WORKDIR /var/www/html
RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080"]
