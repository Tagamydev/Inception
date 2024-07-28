#!/bin/bash

/usr/sbin/php-fpm$(php --version | awk '{print $2}' | head -1 | head -c 3) -F
