#!/bin/bash

echo "DOMAIN_NAME=$USER.42.fr" > ./srcs/.env

read -p "certificates folder: " enter

echo "# certificates" >> ./srcs/.env

echo "CERTS_="${enter} >> ./srcs/.env

echo "# MYSQL SETUP" >> ./srcs/.env

read -p "mysql root password: " enter
echo "MYSQL_ROOT_PASSWORD="${enter} >> ./srcs/.env

read -p "mysql user name: " enter
echo "MYSQL_USER="${enter} >> ./srcs/.env

read -p "mysql user password: " enter
echo "MYSQL_PASSWORD="${enter} >> ./srcs/.env

read -p "mysql hostname: " enter
echo "MYSQL_HOSTNAME="${enter} >> ./srcs/.env

read -p "mysql data base: " enter
echo "MYSQL_DATABASE="${enter} >> ./srcs/.env

