#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

date > /home/madpin/logs/last_every24h.txt

source ../../../docker/website/dump_dbs.sh
source ../BackupBooks.sh
source ../BackupIpynb.sh
source ../BackupCode.sh