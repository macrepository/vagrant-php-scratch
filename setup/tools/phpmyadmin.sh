#!/bin/bash

wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
tar xvf phpMyAdmin-latest-all-languages.tar.gz
sudo rm phpMyAdmin-latest-all-languages.tar.gz
sudo mv phpMyAdmin-*/ /usr/share/phpmyadmin
sudo mkdir -p /var/lib/phpmyadmin/tmp
sudo chown -R apache:apache /var/lib/phpmyadmin
sudo cp /usr/share/phpmyadmin/config.sample.inc.php  /usr/share/phpmyadmin/config.inc.php
sudo sed -i "s/\$cfg\['blowfish_secret'\] = '';/\$cfg\['blowfish_secret'\] = 'H2OxcGXxflSd8JwrwVlh6KW6s2rER63i';/g" /usr/share/phpmyadmin/config.inc.php
echo "\$cfg['TempDir'] = '/var/lib/phpmyadmin/tmp';" | sudo tee -a /usr/share/phpmyadmin/config.inc.php > /dev/null
sudo tee /etc/httpd/conf.d/phpmyadmin.conf &> /dev/null <<EOF
# Apache configuration for phpMyAdmin
Alias /phpMyAdmin /usr/share/phpmyadmin/
Alias /phpmyadmin /usr/share/phpmyadmin/
 
<Directory /usr/share/phpmyadmin/>
   AddDefaultCharset UTF-8
 
   <IfModule mod_authz_core.c>
     # Apache 2.4
     Require all granted
   </IfModule>
   <IfModule !mod_authz_core.c>
     # Apache 2.2
     Order Deny,Allow
     Deny from All
     Allow from 127.0.0.1
     Allow from ::1
   </IfModule>
</Directory>
EOF