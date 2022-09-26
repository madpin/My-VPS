#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

date > /home/madpin/logs/last_every5min.txt

# rclone sync /home/madpin/ipynbs pcloud:/VPSBackup/ipynbs --exclude ".*/**" -P --log-file /home/madpin/logs/rclone-VPSBackup-ipynbs.log