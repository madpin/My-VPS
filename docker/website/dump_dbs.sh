docker exec wordpress_db sh -c 'exec mysqldump --all-databases -uroot -prandom_password' > ~/configs/website/bkp/wordpress_db.sql
docker exec mariadb_lychee sh -c 'exec mysqldump --all-databases -uroot -prootpassword' > ~/configs/website/bkp/mariadb_lychee.sql