install_wordpress:
pkg.installed:
- pkgs:
- apache2
- mysql-server
- mysql-client
- php
- libapache2-mod-php
- php-mysql
- wordpress

wordpress_config:
cmd.run:
- name: echo "Alias /blog /usr/share/wordpress


<Directory /usr/share/wordpress>

Options FollowSymLinks

AllowOverride Limit Options FileInfo

DirectoryIndex index.php

Order allow,deny

Allow from all

</Directory>

<Directory /usr/share/wordpress/wp-content>

Options FollowSymLinks

Order allow,deny

Allow from all

</Directory>" > /etc/apache2/sites-available/wordpress.conf
- cwd: /

wordpress_a2ensite:
cmd.run:
- name: a2ensite wordpress
- cwd: /

Enable_a2enmod:
cmd.run:
- name: a2enmod rewrite
- cwd:

restart_apache_service:
cmd.run:
- name: systemctl restart apache2
- cwd: /

create_wordpress_database:
cmd.run:
- name: mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;"
- cwd: /

create_user:
cmd.run:
- name: mysql -u root -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost IDENTIFIED BY 'test';"
- cwd: /

flush_priv:
cmd.run:
- name: mysql -u root -e "FLUSH PRIVILEGES;"
- cwd: /

create_config:
cmd.run:
- name: echo "<?php

define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'test');
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR','/usr/share/wordpress/wp-content');
?>" > /etc/wordpress/config-10.0.6.168.php
- cwd: /

restart_mysql_service:
cmd.run:
- name: service mysql start
