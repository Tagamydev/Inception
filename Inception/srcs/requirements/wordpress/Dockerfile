# Image of penultimate stable version of Debian.
FROM srcs-base_img

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get install \
	php \
	php-cgi \
	php-mysql \
	php-fpm \
	php-pdo \
	php-gd php-cli \
	php-mbstring \
	wget -y

EXPOSE 9000

COPY ./conf/www.conf /
RUN mv /www.conf /etc/php/$(php --version | awk '{print $2}' | head -1 | head -c 3)/fpm/pool.d/

RUN mkdir -p /run/php

WORKDIR /var/www/html/

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxvf latest.tar.gz
RUN mv wordpress/* .
RUN rm -rf wordpress
RUN chown -R www-data:www-data *
RUN mv wp-config-sample.php wp-config.php

WORKDIR /
COPY ./tools/start_php.sh /

CMD ["bash", "/start_php.sh"]
