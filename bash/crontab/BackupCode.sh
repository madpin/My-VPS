#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

rclone sync ~/code pcloud:/VPSBackup/code --exclude ".*/**" --exclude "*/.git/**" --exclude "*/.venv/**" --exclude "*/venv/**" -P