#!/bin/bash

#Enable remi's repository
sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

#Enable PHP 8.2
sudo dnf -y module reset php
sudo dnf -y module enable php:remi-8.2

#Install php and extensions
sudo dnf -y install php
sudo dnf -y install php-{cli,fpm,mysqlnd,devel,mcrypt,xml,pear,memcache,redis,bcmath,ctype,curl,dom,fileinfo,gd,hash,iconv,intl,json,libxml,mbstring,openssl,pcre,pdo_mysql,simplexml,soap,sockets,sodium,tokenizer,xmlwriter,xsl,zip}
sudo dnf -y install libxml2
sudo dnf -y install openssl-devel

sudo sed -i 's/memory_limit = 128M/memory_limit = 2G/g' /etc/php.ini
sudo sed -i 's/;realpath_cache_size = 4096k/realpath_cache_size=10M/g' /etc/php.ini
sudo sed -i 's/;realpath_cache_ttl = 120/realpath_cache_ttl=7200/g' /etc/php.ini