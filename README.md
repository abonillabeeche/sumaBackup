# SUSE Manager backup with SUSE Enterprise Storage

The script start the Network interface in the Storage network and maps the block device - Then it performs a backup of the content of the SUSE Manager server, as well as a database backup.

##Backup SUSE Manager using RBD/CEPH - run ONCE

- Create the backup pool (modify PGs as needed)

$ ceph osd pool create backup 256

- Create the volumes, directory and required permissions

$ rbd -p backup create sumaBackup --size 140860

$ rbd -p backup map sumaBackup

$ mkfs.xfs /dev/rbd/backup/sumaBackup

$ mount /dev/rbd/backup/sumaBackup /mnt/

$ mkdir /mnt/db

$ chown postgres:postgres /mnt/db/

$ chmod 700 /mnt/db/

- Copy sumaBackup.sh inside the mapped and mounted volume (into /mnt as performed above) - so nothing will be performed if rbd map and mount were not successful.

$ cp sumaBackup.sh /mnt/

$ umount /mnt

$ rbd unmap /dev/rbd/backup/sumaBackup

$ rbd showmapped

- Create a cron entry to execute the backup job
