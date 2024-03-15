#!/bin/sh

# WP-CLI cmd: Generate wp-config.php file
wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_USER_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root 

# WP-CLI cmd: Runs standard WP installation process
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# WP-CLI cmd: Create user
wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --allow-root

# Start php-fpm service (-F: stay in foreground + bypass daemonize option from config file)
/usr/sbin/php-fpm7 -F 
