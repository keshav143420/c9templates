#!/bin/bash

DEFAULT="deb http://archive.ubuntu.com/ubuntu/ groovy main restricted
deb-src http://archive.ubuntu.com/ubuntu/ groovy main restricted
deb http://archive.ubuntu.com/ubuntu/ groovy-updates main restricted
deb-src http://archive.ubuntu.com/ubuntu/ groovy-updates main restricted
deb http://archive.ubuntu.com/ubuntu/ groovy universe
deb-src http://archive.ubuntu.com/ubuntu/ groovy universe
deb http://archive.ubuntu.com/ubuntu/ groovy-updates universe
deb-src http://archive.ubuntu.com/ubuntu/ groovy-updates universe
deb http://archive.ubuntu.com/ubuntu/ groovy-security main restricted
deb-src http://archive.ubuntu.com/ubuntu/ groovy-security main restricted
deb http://archive.ubuntu.com/ubuntu/ groovy-security universe
deb-src http://archive.ubuntu.com/ubuntu/ groovy-security universe"

GCE="deb http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy main restricted
deb-src http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy main restricted
deb http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-updates main restricted
deb-src http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-updates main restricted
deb http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy universe
deb-src http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy universe
deb http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-updates universe
deb-src http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-updates universe
deb http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy multiverse
deb-src http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy multiverse
deb http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-updates multiverse
deb-src http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-updates multiverse
deb http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-backports main restricted universe multiverse
deb-src http://REPLACE.gce.clouds.archive.ubuntu.com/ubuntu/ groovy-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu groovy-security main
deb-src http://security.ubuntu.com/ubuntu groovy-security main
deb http://security.ubuntu.com/ubuntu groovy-security universe
deb-src http://security.ubuntu.com/ubuntu groovy-security universe"

[[ $1 == -o ]] && stdout=true

if curl -Ss metadata &>/dev/null; then
	REGION=$(curl -Ss -H "Metadata-Flavor: Google" metadata/computeMetadata/v1/instance/zone | sed -r 's#.*zones/((europe|us|asia)-[a-z0-9]*).*#\1#')
	OUT="${GCE//REPLACE/$REGION}"
else
	OUT="$DEFAULT"
fi

if [[ $stdout ]]; then
	echo "$OUT"
else
	rm /etc/apt/sources.list
	touch /etc/apt/sources.list
	echo "$OUT" > /etc/apt/sources.list.d/c9.list
fi
