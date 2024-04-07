#!/bin/bash

# Start server httpd
sudo systemctl start httpd
echo "httpd started OK";

# Start php-fpm
sudo systemctl start php-fpm
echo "php-fpm started OK";

# Start mysqld
sudo systemctl start mysqld
echo "mysqld started OK";

# Start Mailhog
sudo systemctl start mailhog.service &
echo "Mailhog Started OK";