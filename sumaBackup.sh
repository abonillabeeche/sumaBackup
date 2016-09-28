#!/bin/bash
FILES="/etc/sysconfig/rhn/
/etc/rhn/
/etc/sudoers
/srv/www/htdocs/pub/
/root/.gnupg/
/root/ssl-build/
/etc/dhcpd.conf
/srv/tftpboot/
/var/lib/cobbler/
/var/lib/rhn/kickstarts/
/srv/www/cobbler
/var/lib/named/master
/etc/named.conf
/etc/named.conf.include
/etc/named.d
/etc/resolv.conf"
for f in $FILES
do
        echo "Copying "$f
        cp -r $f /mnt/files
done
	echo -e "\e[31mPerforming Database Backup\e[0m"        
        smdba backup-hot --enable=on --backup-dir=/mnt/db
        echo -e "\e[31mSyncing Repo content\e[0m"
        rsync -a /var/spacewalk/ /mnt/spacewalk/
