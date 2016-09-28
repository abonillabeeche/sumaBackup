#!/bin/bash
echo -e "\e[31mEnabling network and Storage\e[0m"
ifconfig eth0:0 192.168.124.253/24 up
rbd -p backup map sumaBackup
sleep 1
mount /dev/rbd/backup/sumaBackup /mnt/
echo -e "\e[31mRunning Backup Job\e[0m"
echo -e "\e[31mVerifying Backup structure\e[0m"
if [ -d "/mnt/db" ]
then
    sh /root/sumaBackup.sh
    sync
    sleep 1
    echo -e "\e[31mBackup Finished - Disabling Network and Storage\e[0m"
    umount /mnt
    rbd unmap /dev/rbd1
    #ifconfig eth0:0 down
else
    echo "Error: Directory /mnt/db does not exists."
    exit 1
fi
