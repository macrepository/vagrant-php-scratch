#!/bin/bash

# Set custom Configurations
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Set permission
sudo sed -i 's/User apache/User vagrant/g' /etc/httpd/conf/httpd.conf
sudo sed -i 's/Group apache/Group vagrant/g' /etc/httpd/conf/httpd.conf

# Set php permission
sudo chown -R vagrant:vagrant /var/lib/php

