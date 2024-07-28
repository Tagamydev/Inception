# Image of penultimate stable version of Debian.
FROM srcs-base_img

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get install mariadb-server mariadb-client -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

RUN service mariadb start

WORKDIR /home/
COPY ./tools/mariadb_config.sh /home/
RUN chmod +x /home/mariadb_config.sh

RUN ./mariadb_config.sh

CMD ["mysqld_safe"]
