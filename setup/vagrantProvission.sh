#!/bin/bash

print() {
    local message="$1"
    local isError="$2"

    # Check if the message should be printed as an error
    if [[ "$isError" == true ]]; then
        # Print in red
        echo -e "\033[31m${message}\033[0m"
    else
        # Print in default console color
        echo "${message}"
    fi
}

# Start setup
. /var/ssh/setup/tools/start-installation.sh

# Install Apache 2.4.57
. /var/ssh/setup/tools/apache.sh
if command -v httpd >/dev/null 2>&1; then
    print "Apache HTTP Server (httpd) is installed."
    apache_installed=true
else
    print "Apache HTTP Server (httpd) is not installed. Please install Apache." true
    apache_installed=false
fi

# Install PHP 8.2
. /var/ssh/setup/tools/php82.sh
if php -v >/dev/null 2>&1; then
    print "PHP is installed."
    php_installed=true
else
    print "PHP is not installed. Please install PHP." true
    php_installed=false
fi

# Install mysql 8.0
. /var/ssh/setup/tools/mysqld80.sh
if mysql --version > /dev/null 2>&1; then
    print "MySQL is installed."
    mysql_installed=true
else
    print "MySQL is not installed. Please install MySQL." true
    mysql_installed=false
fi

if [ "$php_installed" = true ]; then
    # add composer 2.6
    . /var/ssh/setup/tools/composer.sh
    print "Composer installed"

    # Add mailhog
    . /var/ssh/setup/tools/mailhog-install.sh
    print "Mailhog installed"
else
    print "Composer is not installed." true
fi

# Check if MySQL is installed
if [ "$mysql_installed" = true ]; then
    # setup phpmyadmin
    . /var/ssh/setup/tools/phpmyadmin.sh
    print "phpMyAdmin installed"
else
    print "phpMyAdmin is not installed." true
fi

if [ "$apache_installed" = true ] && [ "$php_installed" = true ]; then
    # Set custom server configurations
    . /var/ssh/setup/tools/custom-server-configuration.sh
    print "Custom configuration was set."

    # Install ssl needed tools
    . /var/ssh/setup/tools/ssl.sh
else 
    print "Cannot configure server settings due to imcomplete package installtion" true
fi

# End setup