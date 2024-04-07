#!/bin/bash

sudo dnf module list mysql
sudo dnf -y install @mysql:8.0
rpm -qi mysql-server

sudo systemctl enable --now mysqld