#!/bin/bash
mkdir -p ~/configs/website/
mkdir -p ~/configs/website/bkp/
docker exec wordpress_db sh -c 'exec mysqldump --all-databases -uroot -prandom_password' | gzip -9 > ~/configs/website/bkp/wordpress_db.sql.gz
docker exec lychee_db sh -c 'exec mysqldump --all-databases -uroot -prandom_password' | gzip -9 > ~/configs/website/bkp/lychee_db.sql.gz