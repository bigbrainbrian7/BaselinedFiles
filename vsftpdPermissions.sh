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

sudo sh -c 'cat <<EOF > /etc/logrotate.d/vsftpd
/var/log/vsftpd.log {
    create 640 root adm

    missingok
    notifempty
    rotate 4
    weekly
}
EOF'
