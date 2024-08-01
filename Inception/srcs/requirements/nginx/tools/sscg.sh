#!/bin/sh

# Self Signed Certificate Generator


mkdir -p /tmp/certi/$CERTS_/cert/
mkdir -p /tmp/certi/$CERTS_/key/

cert_existence=$(ls /tmp/certi/$CERTS_/cert/ | grep *.pem | wc -l)
key_existence=$(ls /tmp/certi/$CERTS_/key/ | grep *.pem | wc -l)

if [ $cert_existence -eq 0 ] || [ $key_existence -eq 0 ]; then
	/bin/rm -rf /tmp/certi/*
	mkdir -p /tmp/certi/$CERTS_/cert/
	mkdir -p /tmp/certi/$CERTS_/key/
	openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem -subj "/C=ES/ST=Madrid/L=Madrid/O=$DOMAIN_NAME/CN=$DOMAIN_NAME"
	mv key.pem /tmp/certi/$CERTS_/key/
	mv cert.pem /tmp/certi/$CERTS_/cert/
fi

cp /tmp/certi/$CERTS_/cert/*.pem /etc/ssl/certs/cert.pem
cp /tmp/certi/$CERTS_/key/*.pem /etc/ssl/private/key.pem

exec "$@"
