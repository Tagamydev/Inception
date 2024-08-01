#!/bin/sh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install_wordpress.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: samusanc <samusanc@student.42madrid.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/29 07:57:13 by samusanc          #+#    #+#              #
#    Updated: 2024/07/29 07:57:13 by samusanc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

install_wp()
{
	ls > result.txt
	rm -rf *
	ls > result_after.txt
	wget https://wordpress.org/latest.tar.gz
	tar -zxvf latest.tar.gz

	mv wordpress/* .
	rm -rf wordpress
	chown -R www-data:www-data *
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	mv wp-config-sample.php wp-config.php
}

check_wp_params()
{
	# generating expected file for diff check
	touch expected-file.tmp
	echo "define( 'DB_NAME', '$MYSQL_DATABASE' );" >> expected-file.tmp
	echo "define( 'DB_USER', '$MYSQL_USER' );" >> expected-file.tmp
	echo "define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );" >> expected-file.tmp
	echo "define( 'DB_HOST', '$MYSQL_HOSTNAME' );" >> expected-file.tmp

	# generating result file for diff check
	touch result-file.tmp
	cat wp-config.php | grep "DB_NAME', '"$MYSQL_DATABASE >> result-file.tmp
	cat wp-config.php | grep "DB_USER', '"$MYSQL_USER >> result-file.tmp
	cat wp-config.php | grep "DB_PASSWORD', '"$MYSQL_PASSWORD >> result-file.tmp
	cat wp-config.php | grep "DB_HOST', '"$MYSQL_HOSTNAME >> result-file.tmp

	dos2unix result-file.tmp
	file_diff=$(diff expected-file.tmp result-file.tmp | wc -l)
	rm -rf expected-file.tmp
	rm -rf result-file.tmp
	if [ $file_diff -eq 0 ]; then
		echo "wp well configurated!!!"
	else
		echo "wp bad configurated, starting wp reinstallation..."
		install_wp
	fi
}

check_wp()
{
	pwd > pwd.tmp
	echo "/var/www/html" > expected_pwd.tmp
	nice_pwd=$(diff pwd.tmp expected_pwd.tmp | wc -l)
	rm -rf pwd.tmp
	rm -rf expected_pwd.tmp

	# check wp pwd
	if [ $nice_pwd -eq 0 ]; then

		check_config_file=$(ls | grep "wp-config.php" | wc -l ) 
		# check the wp-config file
		if [ $check_config_file -eq 1 ]; then
			echo "wp configurated, checking parameters..."
			check_wp_params
		else
			echo "this is the ls command output: "
			pwd
			ls
			echo "wp not installed, starting download..."
			install_wp
		fi
	
	else
		echo "this is bad"
		echo "Error: bad directory"
		echo "trying to make and reach directory..."
		mkdir -p /var/www/html
		cd /var/www/html
		check_wp
	fi
}

check_wp
exec "$@"
