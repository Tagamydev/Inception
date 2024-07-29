#!/bin/sh

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chmod 777 /var/run/mysqld

service mariadb start

echo "zone 1"
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


echo "zone 2"
echo "GRANT ALL ON *.* TO 'jefaso'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mariadb -uroot
echo "zone 3"
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mariadb -u root

echo "zone 4"
# save data base
mariadb -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
echo "zone 5"

ls -la /var/lib/mysqld/

fi

service mariadb stop
echo "finish configure the data base"

exec "$@"
