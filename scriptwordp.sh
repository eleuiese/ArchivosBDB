#!/bin/bash
MYSQL_ADMIN="root";
MYSQL_PASS="rita1234";
DB_NAME="wordpress";
DB_WORD_USER="admin";
DB_WORD_PASS="1234";

#instalar php7.2 con extensiones
sudo apt-get update
apt-get install python-software-properties -y
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.2 -y
sudo apt -y install php7.2-curl php7.2-gd php7.2-mbstring php7.2-xml php7.2-zip
sudo apt -y install php7.2-mysql php7.2-mysqlnd

#instalar apache2
sudo apt -y install apache2
sudo service apache2 restart


#instalar mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password rita1234'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rita1234'
sudo apt-get -y install mysql-server
sudo service mysql restart
mysql -u $MYSQL_ADMIN -p$MYSQL_PASS -e "CREATE DATABASE $DB_NAME;"
mysql -u $MYSQL_ADMIN -p$MYSQL_PASS -e "CREATE USER '$DB_WORD_USER'@'localhost' IDENTIFIED BY '$DB_WORD_PASS';"
mysql -u $MYSQL_ADMIN -p$MYSQL_PASS -e "GRANT ALL PRIVILEGES ON $DB_NAME. * TO '$DB_WORD_USER'@'localhost';"
mysql -u $MYSQL_ADMIN -p$MYSQL_PASS -e "FLUSH PRIVILEGES;"
mysql -u $MYSQL_ADMIN -p$MYSQL_PASS -e "SHOW DATABASES;"
mysql -u $DB_WORD_USER -p$DB_WORD_PASS -e "SHOW DATABASES;"

#descargar wordpress
cd /var/www/html
wget https://es-co.wordpress.org/latest-es_CO.tar.gz
tar -zxvf latest-es_CO.tar.gz
sudo mv wordpress prueba
sudo chmod 777 -R prueba
sudo service apache2 restart
