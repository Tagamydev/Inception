#!/bin/sh

service mariadb start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else

mysql_secure_installation << _EOF_
n
n
n
Y
Y
Y
Y
_EOF_


echo "GRANT ALL ON *.* TO 'jefaso'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mariadb -uroot
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mariadb -u root
mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

service mariadb stop
echo "finish configure the data base"

exec "$@"
