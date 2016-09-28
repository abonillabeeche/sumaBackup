# SUSE Manager backup with SUSE Enterprise Storage

Backup SUSE Manager using RBD/CEPH - Run ONCE

- Create the backup pool (modify PGs as needed)
ceph osd pool create backup 256

- Create the volumes and directory and required permissions
rbd -p backup create sumaBackup --size 140860

rbd -p backup map sumaBackup

mkfs.xfs /dev/rbd/backup/sumaBackup

mount /dev/rbd/backup/sumaBackup /mnt/

mkdir /mnt/db

chown postgres:postgres /mnt/db/

chmod 700 /mnt/db/

- Copy sumaBackup.sh inside the volume into /mnt - nothing will be performed if rbd map and mount were not successful.  Then:

umount /mnt

rbd unmap /dev/rbd/backup/sumaBackup

rbd showmapped

- Create a cron entry to execute the backup job
