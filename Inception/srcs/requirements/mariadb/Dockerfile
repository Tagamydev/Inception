# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: samusanc <samusanc@student.42madrid.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/29 11:13:36 by samusanc          #+#    #+#              #
#    Updated: 2024/07/29 14:10:44 by samusanc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Image of penultimate stable version of Debian.
FROM srcs-base_img

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get install mariadb-server mariadb-client -y

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod 777 /var/run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

RUN service mariadb start

WORKDIR /home/
COPY ./tools/mariadb_config.sh /home/
RUN chmod +x /home/mariadb_config.sh

ENTRYPOINT ["/home/mariadb_config.sh"]

CMD ["mysqld_safe"]
