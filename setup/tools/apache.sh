#!/bin/bash

# Install httpd
sudo dnf -y install httpd
sudo dnf -y install httpd-devel

# Set permission
sudo sed -i 's/User apache/User vagrant/g' /etc/httpd/conf/httpd.conf
sudo sed -i 's/Group apache/Group vagrant/g' /etc/httpd/conf/httpd.conf

# Enable and start the httpd service.
sudo systemctl enable --now httpd.service