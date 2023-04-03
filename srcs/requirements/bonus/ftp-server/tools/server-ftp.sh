#!/bin/sh

set -xv

if [ ! -f "/etc/vsftpd.userlist" ]; then

	useradd $FTP_USER_NAME
	echo $FTP_USER_NAME:$FTP_USER_PASS | chpasswd 
	echo $FTP_USER_NAME | tee -a  /etc/vsftpd.userlist

	echo "write_enable=YES" >> /etc/vsftpd.conf
	echo "chroot_local_user=YES" >> /etc/vsftpd.conf
	echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
	sed -i 's/secure_chroot_dir=\/var\/run\/vsftpd\/empty/secure_chroot_dir=\/home\/bperriol/' /etc/vsftpd.conf
	echo "pasv_enable=YES" >> /etc/vsftpd.conf
	echo "pasv_min_port=40000" >> /etc/vsftpd.conf
	echo "pasv_max_port=40009" >> /etc/vsftpd.conf
	echo "userlist_enable=YES" >> /etc/vsftpd.conf
	echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf
	echo "userlist_deny=NO" >> /etc/vsftpd.conf
	echo "listen_port=21" >> /etc/vsftpd.conf
	echo "listen_address=0.0.0.0" >> /etc/vsftpd.conf
	echo "local_umask=022" >> /etc/vsftpd.conf
	echo "chroot_local_user=YES" >> /etc/vsftpd.conf

	mkdir -p $FTP_USER_HOME/ftp
	chmod a+w $FTP_USER_HOME/ftp
	chown -R $FTP_USER_NAME:$FTP_USER_NAME /home/bperriol/
fi

exec "$@"
