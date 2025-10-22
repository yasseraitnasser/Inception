FROM debian:bookworm

RUN apt-get update -y && apt-get install -y --no-install-recommends \
	nginx

RUN mkdir -p /var/www/static
COPY index.html /var/www/static/

COPY nginx.conf /etc/nginx/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
