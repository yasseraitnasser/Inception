#!/bin/bash

WP_PATH="/var/www/html"

until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1;" &>/dev/null; do
	echo "Waiting for database to be ready..."
	sleep 1
done
echo "Database is ready!"

echo "Downloading WordPress..."
wp core download --path="$WP_PATH" --allow-root > /dev/null

echo "Creating wp-config.php..."
wp config create \
    --path="$WP_PATH" \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="$DB_HOST" \
    --allow-root > /dev/null

echo "Configuring Redis cache..."
wp config set WP_REDIS_HOST redis --allow-root --path="$WP_PATH"
wp config set WP_REDIS_PORT 6379 --raw --allow-root --path="$WP_PATH"
wp config set WP_CACHE true --raw --allow-root --path="$WP_PATH"

echo "Installing WordPress..."
wp core install \
    --path="$WP_PATH" \
    --url="https://$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root > /dev/null

echo "Adding user..."
wp user create \
	"$WP_USER" "$WP_USER_EMAIL" \
	--path="$WP_PATH" \
	--user_pass="$WP_USER_PASSWORD" \
	--role="author" \
	--allow-root > /dev/null

echo "Installing Redis Object cache plugin..."
wp plugin install redis-cache --activate --allow-root --path="$WP_PATH" > /dev/null
wp redis enable --allow-root --path="$WP_PATH" > /dev/null

echo "WordPress installation complete!"

chown -R www-data:www-data "$WP_PATH"
chmod -R 755 "$WP_PATH"

echo "Starting PHP-FPM..."
exec php-fpm8.2 --nodaemonize
