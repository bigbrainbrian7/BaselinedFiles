#!/bin/bash
useradd -s /sbin/nologin ftpsecure

# Set ownership for files
sudo chown -R root:root /etc/vsftpd.conf /etc/ftpusers

#Set ownership for document roots (/var/www)
sudo chown -R ftpsecure:ftpsecure /var/www

#Set ownership for apache2 log
sudo chown root:root /var/log/xferlog /var/log/vsftpd.log*
sudo chown root:adm /var/log/vsftpd.log

# Set permissions for files
sudo find /var/run/vsftpd -type f -exec chmod 644 {} \;
sudo chmod 644 /etc/vsftpd.conf /etc/ftpusers
sudo chmod 600 /var/log/vsftpd.log* /var/log/xferlog
sudo chmod 640 /var/log/vsftpd.log

# Set permissions for directories
sudo find /var/www -type d -exec chmod 755 {} \;
sudo find /var/run/vsftpd -type d -exec chmod 755 {} \;


# Set permission for parent directories
sudo chmod 755 /etc
sudo chmod 775 /var/log
sudo chmod 755 /var/www
sudo chmod 755 /var/run
sudo chmod 755 /var
sudo chmod 755 /

# Set permission for binary, though in theory should have another script setting all binaries to 755
sudo chmod 755 /usr/sbin/vsftpd

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

