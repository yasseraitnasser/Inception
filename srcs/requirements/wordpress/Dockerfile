FROM debian:bookworm

RUN apt-get update -y && apt-get install -y --no-install-recommends \
	php8.2 php8.2-fpm php-mysql php-xml php-mbstring php-curl php-gd \
	curl less php-zip php-intl php-bcmath wget mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

COPY php-fpm.conf /etc/php/8.2/fpm/php-fpm.conf

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]
