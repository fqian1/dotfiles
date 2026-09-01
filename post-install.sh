#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "Must be run as super user"
	return 1
fi

chmod 600 "$XDG_CONFIG_HOME"/wireguard/*
chown root:wheel "$XDG_CONFIG_HOME"/wireguard/*
