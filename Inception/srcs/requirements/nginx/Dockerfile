# Image of penultimate stable version of Debian.
#FROM debian:bullseye
FROM srcs-base_img:latest

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get install nginx -y

# Self Signed Certificate Generator script
COPY ./tools/sscg.sh /home/

WORKDIR	/home/

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
