#!/bin/bash

# Install httpd
sudo dnf -y install httpd
sudo dnf -y install httpd-devel

# Enable and start the httpd service.
sudo systemctl enable --now httpd.service