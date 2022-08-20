#!/bin/bash

PATH=/usr/local/bin:/usr/bin:/home/madpin/bin:/usr/local/sbin:/usr/sbin

rclone sync ~/calibre_library mega:/VPSBackups/calibre/library
rclone sync ~/configs/calibre mega:/VPSBackups/calibre/configs

rclone sync ~/calibre_library onedrive:/VPSBackups/calibre/library
rclone sync ~/configs/calibre onedrive:/VPSBackups/calibre/configs

rclone sync ~/calibre_library pcloud:/VPSBackups/calibre/library
rclone sync ~/configs/calibre pcloud:/VPSBackups/calibre/configs