#!/bin/bash

FTP_USER=${FTP_USER:-user}
FTP_PASS=${FTP_PASS:-pass}

mkdir -p /home/vsftpd/$FTP_USER

echo -e "$FTP_PASS\n$FTP_PASS" | (passwd $FTP_USER)

chown -R ftp:ftp /home/vsftpd/$FTP_USER

cat <<EOL > /etc/vsftpd/vsftpd.conf
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
pasv_enable=YES
pasv_min_port=21100
pasv_max_port=21110
EOL

# Start the vsftpd service
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
