#!/bin/bash

# This script expects the filename without extension as an argument
CONF_NAME=$1
BASEDIR="/var/www/html"

create_work_directory () {
    WORKDIR="${BASEDIR}/${CONF_NAME}"
    # Increment folder name if already exists
    COUNTER=1
    while [ -d "$WORKDIR" ]; do
        CONF_NAME="${CONF_NAME}_$COUNTER"
        WORKDIR="${BASEDIR}/${CONF_NAME}"
        ((COUNTER++))
    done

    # Create the working directory and index.php
    mkdir -p "$WORKDIR"
    cat << EOF > "${WORKDIR}/index.php"
<?php
phpinfo();
EOF
}

set_conf () {
    # Full path to the config file
    CONF_FILE="/etc/httpd/conf.d/${CONF_NAME}.conf"

    # Create or overwrite the Apache configuration file
    sudo bash -c "cat << EOF > ${CONF_FILE}
<VirtualHost *:80>
    ServerName ${CONF_NAME}.com
    ServerAlias www.${CONF_NAME}.com
    DocumentRoot "${WORKDIR}"

    <Directory "${WORKDIR}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

<VirtualHost *:443>
    ServerName ${CONF_NAME}.com:443
    ServerAlias www.${CONF_NAME}.com
    DocumentRoot "${WORKDIR}"

    SSLEngine on
    SSLCertificateFile "/var/ssh/setup/ssl/ssl.crt"
    SSLCertificateKeyFile "/var/ssh/setup/ssl/ssl.key"

    <Directory "${WORKDIR}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF"

    echo "Configuration for ${CONF_NAME} has been set."
    echo "Please set your domain name ${CONF_NAME}.com at your machine /etc/hosts"
}

# Check if a configuration name was provided
if [[ -z "$CONF_NAME" ]]; then
    echo -e "\033[31mUsage: $0 Please specify hostname\033[0m"
    echo "./setconf.sh <hostname>"
else
    create_work_directory
    set_conf
fi
