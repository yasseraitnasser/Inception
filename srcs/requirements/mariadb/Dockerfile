FROM debian:bookworm

RUN apt-get update -y && apt-get install -y --no-install-recommends mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "[mysqld]\nbind-address = 0.0.0.0\nport = 3306" >> /etc/mysql/my.cnf

COPY mariadb_init.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mariadb_init.sh

EXPOSE 3306

CMD ["/usr/local/bin/mariadb_init.sh"]
