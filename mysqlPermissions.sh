#!/bin/bash
#Mysql secure installation
#Focus: Secure priveleges in server, secure users (no anonmymous)
#mysqld --verbose --help
#Remove local users
#Baseline /var/lib permissions
#Either user or mysql auto generates certificate, research
#SSL permissions sufficient, if want more: https://techdocs.broadcom.com/us/en/ca-enterprise-software/layer7-api-management/api-gateway/10-0/install-configure-upgrade/enable-ssl-connections-for-mysql.html

sudo chown -R root:root /etc/mysql

sudo chown -R mysql:adm /var/log/mysql

sudo chown mysql:mysql /var/log/mysql/query*

sudo find /etc/mysql -type f ! -name "debian.cnf" -exec chmod 644 {} +

sudo chmod 600 /etc/mysql/debian.cnf

sudo find /var/log/mysql -type f -exec chmod 640 {} +

sudo find /etc/mysql -type d -exec chmod 755 {} \;

sudo chmod 750 /var/log/mysql

sudo chmod 755 /etc
sudo chmod 775 /var/log
sudo chmod 755 /var/run
sudo chmod 755 /var
sudo chmod 755 /

sudo chmod 755 /usr/sbin/mysqld

sudo openssl req -newkey rsa:2048 -nodes -keyout /etc/mysql/ssl/mysqlkey.pem -x509 -days 365 -out /etc/mysql/ssl/mysqlcrt.pem

sudo mkdir /etc/mysql/ssl

sudo chown -R mysql:mysql /etc/mysql/ssl

sudo find / -name .mysql_history
