# ses
A few scripts for SUSE Enterprise Storage/CEPH

Backup SUSE Manager using RBD/CEPH

- Create the backup pool (modify PGs as needed)
ceph osd pool create backup 256

- Run Once to create the volumes and paths
rbd -p backup create sumaBackup --size 140860

rbd -p backup map sumaBackup

mkfs.xfs /dev/rbd/backup/sumaBackup

mount /dev/rbd/backup/sumaBackup /mnt/

mkdir /mnt/db

chown postgres:postgres /mnt/db/

chmod 700 /mnt/db/

- Copy sumaBackup.sh inside the volume into /mnt

- Create a cron entry to execute the backup job
