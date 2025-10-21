#!/bin/bash

mkdir -p /etc/ssl/certs /etc/ssl/private

openssl req -x509 -noenc \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/server.key \
	-out /etc/ssl/certs/server.crt \
	-subj "/C=MA/O=1337/CN=yait-nas.42.fr"
