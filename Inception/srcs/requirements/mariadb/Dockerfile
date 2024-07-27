# Image of penultimate stable version of Debian.
FROM srcs-base_img:latest

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

#RUN service mysql start && \
#    mysql_secure_installation

#CMD ["mysqld_safe"]
