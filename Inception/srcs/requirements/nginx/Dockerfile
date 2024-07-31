# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: samusanc <samusanc@student.42madrid.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/29 11:13:00 by samusanc          #+#    #+#              #
#    Updated: 2024/07/29 11:13:06 by samusanc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Image of penultimate stable version of Debian.
FROM srcs-base_img

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get install nginx -y

# Self Signed Certificate Generator script
COPY ./tools/sscg.sh /home/

WORKDIR	/home/

COPY ./tools/sscg.sh /home/
# Generating pem certificates for ssl
RUN bash sscg.sh
RUN mv ./key.pem /etc/ssl/private/ && mv ./cert.pem /etc/ssl/certs/
RUN rm -rf sscg.sh

# Copy nginx config
COPY ./conf/nginx.conf /etc/nginx/

# Copy sites config for ssl
COPY ./conf/default /etc/nginx/sites-enabled/default

EXPOSE 443

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
