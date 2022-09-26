#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

date > /home/madpin/logs/last_backupbooks.txt

rclone sync ~/calibre_library mega:/VPSBackups/calibre/library --log-file /home/madpin/logs/rclone-mega-VPSBackup-library.log
rclone sync ~/configs/calibre mega:/VPSBackups/calibre/configs --log-file /home/madpin/logs/rclone-mega-VPSBackup-configs.log

rclone sync ~/calibre_library onedrive:/VPSBackups/calibre/library --log-file /home/madpin/logs/rclone-onedrive-VPSBackup-library.log
rclone sync ~/configs/calibre onedrive:/VPSBackups/calibre/configs --log-file /home/madpin/logs/rclone-onedrive-VPSBackup-configs.log

rclone sync ~/calibre_library pcloud:/VPSBackups/calibre/library --log-file /home/madpin/logs/rclone-pcloud-VPSBackup-library.log
rclone sync ~/configs/calibre pcloud:/VPSBackups/calibre/configs --log-file /home/madpin/logs/rclone-pcloud-VPSBackup-configs.log