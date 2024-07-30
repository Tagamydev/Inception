#!/bin/sh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    mariadb_config.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: samusanc <samusanc@student.42madrid.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/30 07:04:40 by samusanc          #+#    #+#              #
#    Updated: 2024/07/30 07:04:40 by samusanc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chmod 777 /var/run/mysqld

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


echo "GRANT ALL ON *.* TO 'jefaso'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mariadb -u root
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mariadb -u root
mariadb -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /home/wordpress.sql
echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1');" | mariadb -u root

fi

service mariadb stop
echo "finish configure the data base"

exec "$@"
