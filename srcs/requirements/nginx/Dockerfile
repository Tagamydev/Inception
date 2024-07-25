# Image of latest official ubuntu 
FROM debian:bullseye

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y && apt-get -qq install neofetch nginx

# Install utility packages
RUN apt-get -qq install vim

COPY ./nginx.conf /etc/nginx/

EXPOSE 443
#EXPOSE 80

# Install c compiler packages
CMD ["nginx", "-g", "daemon off;"]
