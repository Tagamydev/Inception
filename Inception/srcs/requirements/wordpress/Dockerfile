# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: samusanc <samusanc@student.42madrid.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/29 11:12:31 by samusanc          #+#    #+#              #
#    Updated: 2024/07/29 11:12:37 by samusanc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Image of penultimate stable version of Debian.
FROM srcs-base_img

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get install \
	dos2unix \
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

WORKDIR /home/

COPY ./tools/install_wordpress.sh /home/
RUN chmod +x /home/install_wordpress.sh

# Here comes an entrypoint, this allows the external volume to be mount and execute the script
# the script needs to be in /bin/sh format, entrypoint by default execute in that format
ENTRYPOINT ["/home/install_wordpress.sh"]

WORKDIR /

COPY ./tools/start_php.sh /

CMD ["bash", "/start_php.sh"]
