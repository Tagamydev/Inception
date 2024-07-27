# Image of penultimate stable version of Debian.
FROM debian:bullseye

# No question/dialog pops up during apt-get install
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages && Install utility packages
RUN apt-get update  -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    systemctl \
    netcat \
    vim
