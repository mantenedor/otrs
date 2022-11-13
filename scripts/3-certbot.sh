#!/bin/bash

DOMAIN="mantendor"
MAIL="test@mantenedor"
HTTP_PORT="8082"
TLS_PORT=""

#apt install snapd -y 
#/usr/lib/snapd/snapd
##snap install core
#snap refresh core
#snap install --classic certbot
#ln -s /snap/bin/certbot /usr/bin/certbot
apt install python3-certbot -y
certbot certonly -n -d $DOMAIN --agree-tos --email "$MAIL" --standalone --http-01-port $HTTP_PORT
certbot certonly --apache
certbot renew --dry-run
