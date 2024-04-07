## Vagrant Environment

A basic environment setup for laravel version 11.

## **Box Information**

Vagrant Box: oraclelinux/9

Vagrant Url: https://oracle.github.io/vagrant-projects/boxes/oraclelinux/9.json

## Environment Installation

#### Prerequisites

- Vagrant (latest)
- VirtualBox (latest)
- VirtualBox extension pack (latest)

### Installation

1. Install vagrant environment

   `vagrant up --provision`

   Note: If timeout occurs during the installation, Please terminate the process **ctrl+c.** Then execute `vagrant reload --provision`

2. After succesfull installation. Reload the Vagrant environment to ensure that the SELinux configuration has taken effect.

   `vagrant reload`

3. Verify if the system requirement was successfully installed.

    ```
    php -v      => version 8.2.17
    mysqld -V   => version 8.0.36
    composer    => version 2.6.6
    Apache      => Apache/2.4.57
    ```

4. If system requirements above is present. Verify below

    Default private IP **192.168.56.2** in **Vagrantfile**. You can change it, whatever you want.

    Start the server:

    ```
    vagrant ssh
    . /var/ssh/setup/tools/start-server.sh
    ```

    Note: if some error occurred due to cannot start httpd. Please execute `vagrant reload`

    - Verify PhpMyadmin http://192.168.56.2/phpmyadmin
    - Verify MailHog http://192.168.56.2:8025

5. Create Working Directory and VirtualHost

    Set Host
    `. /var/ssh/setup/tools/setconf.sh <hostname>`
    Eg:
    `. /var/ssh/setup/tools/setconf.sh local.crud`

    Restart the server
    `. /var/ssh/setup/tools/restart-server.sh`

6. Install Secure MySQL installation

    `mysql_secure_installation`
