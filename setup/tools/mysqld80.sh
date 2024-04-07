#!/bin/bash

# Install mysql 8.0
sudo dnf install mysql-server -y

# Start mysql
sudo systemctl start mysqld.service

# Enable mysql to start automatically
sudo systemctl enable mysqld.service
