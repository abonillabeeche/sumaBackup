#!/bin/bash
rbd -p backup map sumaBackup
mount /dev/rbd/backup/sumaBackup /mnt/
sh /mnt/sumaBackup.sh
sync
umount /mnt
rbd unmap /dev/rbd0
