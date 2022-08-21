#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

rclone copy /home/madpin/ipynbs pcloud:/VPSBackup/ipynbs --exclude ".*/**" 