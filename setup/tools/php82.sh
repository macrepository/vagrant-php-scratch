#!/bin/bash

sudo dnf update -y

# Add EPEL Repository
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y

# Add remi repository
sudo dnf install http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y

# Check available PHP
sudo dnf module list php -y

# Reset PHP Set
sudo dnf module reset php -y

#Enable PHP 8.2
sudo dnf module enable php:remi-8.2 -y

# Install PHP 8.2 and extensions
sudo dnf -y install php
sudo dnf -y install php-{cli,fpm,mysqlnd,devel,mcrypt,xml,pear,memcache,redis,bcmath,ctype,curl,dom,fileinfo,gd,hash,iconv,intl,json,libxml,mbstring,openssl,pcre,pdo_mysql,simplexml,soap,sockets,sodium,tokenizer,xmlwriter,xsl,zip,filter,session}
sudo dnf -y install libxml2
sudo dnf -y install openssl-devel

# Set PHP configuration
sudo sed -i 's/memory_limit = 128M/memory_limit = 2G/g' /etc/php.ini
sudo sed -i 's/;realpath_cache_size = 4096k/realpath_cache_size=10M/g' /etc/php.ini
sudo sed -i 's/;realpath_cache_ttl = 120/realpath_cache_ttl=7200/g' /etc/php.ini

# Set php permission
sudo chown -R vagrant:vagrant /var/lib/php

# Set php-fpm permission
sudo sed -i 's/user = apache/user = vagrant/g' /etc/php-fpm.d/www.conf
sudo sed -i 's/group = apache/group = vagrant/g' /etc/php-fpm.d/www.conf
sudo sed -i 's/;listen.owner = nobody/listen.owner = vagrant/g' /etc/php-fpm.d/www.conf
sudo sed -i 's/;listen.group = nobody/listen.group = vagrant/g' /etc/php-fpm.d/www.conf
sudo sed -i 's/listen.acl_users = apache,nginx/listen.acl_users = apache,nginx,vagrant/g' /etc/php-fpm.d/www.conf