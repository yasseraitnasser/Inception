#!/bin/bash

mariadb-install-db > /dev/null

chown -R mysql:mysql /var/lib/mysql

service mariadb start

until mariadb -e "SELECT 1" > /dev/null; do
    echo "waiting for mariaDB to start..."
    sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

echo "Created a database"

mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"

echo "created a user that has access to the database"

mysql -e "FLUSH PRIVILEGES;"

mysqladmin shutdown > /dev/null

exec mariadbd-safe

# exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0

# #!/bin/bash
# set -e

# mariadb-install-db --user=mysql > /dev/null

# chown -R mysql:mysql /var/lib/mysql

# # Start MariaDB temporarily
# mysqld_safe --nowatch &

# # Wait for MariaDB to be ready
# until mariadb -e "SELECT 1" &> /dev/null; do
#     echo "waiting for MariaDB to start..."
#     sleep 1
# done

# # Create database and user
# mariadb -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
# mariadb -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
# mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
# mariadb -e "FLUSH PRIVILEGES;"

# echo "✅ Database and user setup complete."

# # Stop temporary background server
# mysqladmin shutdown

# # Start MariaDB in the foreground (container main process)
# exec mysqld_safe
