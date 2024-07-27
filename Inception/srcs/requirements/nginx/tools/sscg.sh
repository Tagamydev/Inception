#!/bin/sh

# Self Signed Certificate Generator
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem -subj "/C=ES/ST=Madrid/L=Madrid/O=42/CN=localhost"
