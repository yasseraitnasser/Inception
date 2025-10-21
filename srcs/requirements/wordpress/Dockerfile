FROM debian:bookworm

RUN apt-get update -y && apt-get install -y --no-install-recommends \
	php8.2 php8.2-fpm php-mysql php-xml php-mbstring php-curl php-gd \
	curl less php-zip php-intl php-bcmath wget mariadb-client ca-certificates \
	php8.2-redis && rm -rf /var/lib/apt/lists/*

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

COPY php-fpm.conf /etc/php/8.2/fpm/php-fpm.conf

EXPOSE 9000

COPY wp_init.sh /usr/local/bin/wp_init.sh
RUN chmod +x /usr/local/bin/wp_init.sh

CMD ["/usr/local/bin/wp_init.sh"]
