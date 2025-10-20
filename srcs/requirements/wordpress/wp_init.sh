#!/bin/bash

WP_PATH="/var/www/html"

wp core download --allow-root > /dev/null

until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1;" &>/dev/null; do
	echo "Waiting for database to be ready..."
	sleep 1
done
echo "Database is ready!"

if [ ! -f "$WP_PATH/wp-config.php" ]; then
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

    echo "Installing WordPress..."
    wp core install \
	    --path="$WP_PATH" \
	    --url="$WP_URL" \
	    --title="$WP_TITLE" \
	    --admin_user="$WP_ADMIN" \
	    --admin_password="$WP_ADMIN_PASSWORD" \
	    --admin_email="$WP_ADMIN_EMAIL" \
	    --allow-root > /dev/null
    echo "WordPress installation complete!"
else
	echo "WordPress already initialized, skipping setup."
fi

chown -R www-data:www-data "$WP_PATH"
chmod -R 755 "$WP_PATH"

echo "Starting PHP-FPM..."
exec php-fpm8.2 --nodaemonize
