#!/bin/bash

# Start setup
. /var/ssh/setup/tools/start.sh

# Install Apache
. /var/ssh/setup/tools/apache.sh
if command -v httpd >/dev/null 2>&1; then
    echo "Apache HTTP Server (httpd) is installed."
    apache_installed=true
else
    echo "Apache HTTP Server (httpd) is not installed. Please install Apache."
    apache_installed=false
fi

# Install PHP 8.2
. /var/ssh/setup/tools/php82.sh
if php -v >/dev/null 2>&1; then
    echo "PHP is installed."
    php_installed=true
else
    echo "PHP is not installed. Please install PHP."
    php_installed=false
fi

# Install mysql 8.0
. /var/ssh/setup/tools/mysqld80.sh
if mysql --version > /dev/null 2>&1; then
    mysql_installed = true
else
    echo "MySQL is not installed. Please install MySQL."
    mysql_installed = false
fi

if [ "$php_installed" = true ]; then
    # add composer 2.6
    . /var/ssh/setup/tools/composer.sh
else
    echo "Composer is not installed."
fi

# Check if MySQL is installed
if [ "$mysql_installed" = true ]; then
    # setup phpmyadmin
    . /var/ssh/setup/tools/phpmyadmin.sh
else
    echo "phpMyAdmin is not installed."
fi

if [ "$apache_installed" = true ] && [ "$php_installed" = true ]; then
    # Set custom server configurations
    . /var/ssh/setup/tools/custom-server-configuration.sh
else 
    echo "Cannot configure server settings due to imcomplete package installtion"
fi

# End setup