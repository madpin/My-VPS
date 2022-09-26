#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

date > /home/madpin/logs/last_backupcode.txt

rclone sync ~/code pcloud:/VPSBackup/code --exclude ".*/**" --exclude "*/.git/**" --exclude "*/.venv/**" --exclude "*/venv/**" --log-file /home/madpin/logs/rclone-VPSBackup-code.log