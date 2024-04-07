#!/bin/bash

# Start server httpd
sudo systemctl restart httpd
echo "httpd started OK";

# Start php-fpm
sudo systemctl restart php-fpm
echo "php-fpm started OK";

# Start mysqld
sudo systemctl restart mysqld
echo "mysqld started OK";

# Start Mailhog
sudo systemctl restart mailhog.service &
echo "Mailhog Started OK";