#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "Must be run as sudo"
	return 1
fi

xbps-install -Syu
xbps-install -y curl wget fzf vim pass tmux xdg-user-dirs yazi age nerd-fonts kmscon fontconfig opendoas
xbps-reconfigure -fa

echo "\n\n"
xbps-query -m
echo "\n\n"

xdg-user-dirs-update
fc-cache -fv
