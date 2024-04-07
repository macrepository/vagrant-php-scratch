#!/bin/bash

# Set custom Configurations
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config


