#!/bin/bash

mkdir -p ssl/certs ssl/private

openssl req -x509 -noenc \
	-newkey rsa:2048 \
	-keyout ssl/private/server.key \
	-out ssl/certs/server.crt \
	-subj "/C=MA/O=1337/CN=yait-nas.42.fr"
