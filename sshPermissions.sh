#!/bin/bash
#man 5 sshd_config

# Set ownership for files
sudo chown -R root:root /etc/ssh /etc/ftpusers

#Set ownership for apache2 log
sudo chown root:adm /var/log/auth.log

# Set permissions for files
sudo find /etc/ssh -type f -exec chmod 644 {} \;
sudo find /etc/ssh/*key -type f -exec chmod 600 {} \;
sudo chmod 640 /var/log/auth.log

# Set permissions for directories
sudo find /etc/ssh -type d -exec chmod 755 {} \;


# Set permission for parent directories
sudo chmod 755 /etc
sudo chmod 775 /var/log
sudo chmod 755 /var/run
sudo chmod 755 /var
sudo chmod 755 /

# Set permission for binary, though in theory should have another script setting all binaries to 755
sudo chmod 755 /usr/sbin/sshd

sudo sshd -T
find /home -type f -name 'authorized_keys' -exec echo {} \;
