#!/bin/bash
# Set ownership for server root
sudo chown -R root:root /etc/apache2

#Set ownership for document roots (/var/www)
sudo chown -R www-data:www-data /var/www
sudo chown root:www-data /var/www

#Set ownership for apache2 log
sudo chown -R root:adm /var/log/apache2

# Set permissions for files
sudo find /etc/apache2 -type f -exec chmod 644 {} \;
sudo find /var/www -type f -exec chmod 644 {} \;
sudo find /var/run/apache2 -type f -exec chmod 644 {} \;
sudo find /var/log/apache2 -type f -exec chmod 640 {} \;

# Set permissions for directories
sudo find /etc/apache2 -type d -exec chmod 755 {} \;
sudo find /var/www -type d -exec chmod 755 {} \;
sudo find /var/run/apache2 -type d -exec chmod 755 {} \;
sudo chmod 750 /var/log/apache2

# Set permission for parent directories
sudo chmod 755 /etc/apache2
sudo chmod 755 /etc
sudo chmod 775 /var/log
sudo chmod 755 /var/www
sudo chmod 755 /var/run
sudo chmod 755 /var
sudo chmod 755 /

# Set permission for binary, though in theory should have another script setting all binaries to 755
sudo chmod 755 /usr/sbin/apache2
sudo chmod 755 /usr/sbin/apache2ctl

sudo sh -c 'echo "/var/log/apache2/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 640 root adm
    sharedscripts
    prerotate
	if [ -d /etc/logrotate.d/httpd-prerotate ]; then
	    run-parts /etc/logrotate.d/httpd-prerotate
	fi
    endscript
    postrotate
	if pgrep -f ^/usr/sbin/apache2 > /dev/null; then
	    invoke-rc.d apache2 reload 2>&1 | logger -t apache2.logrotate
	fi
    endscript
}" > /etc/logrotate.d/apache2'

