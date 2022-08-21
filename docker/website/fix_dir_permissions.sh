#!/bin/bash
mkdir -p ${HOME}/configs/website
mkdir -p ${HOME}/configs/website/wordpress
mkdir -p ${HOME}/configs/website/lychee_db
mkdir -p ${HOME}/configs/website/wordpress_db

sudo chown -R $USER ${HOME}/configs/website/wordpress
sudo chgrp -R $USER ${HOME}/configs/website/wordpress
sudo chown -R $USER ${HOME}/configs/website/lychee_db
sudo chgrp -R $USER ${HOME}/configs/website/lychee_db
sudo chown -R $USER ${HOME}/configs/website/wordpress_db
sudo chgrp -R $USER ${HOME}/configs/website/wordpress_db