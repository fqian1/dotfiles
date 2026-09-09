#!/bin/sh

set -eu

if [ "$(id -u)" -ne 0 ]; then
	echo "Must be run as super user"
	return 1
fi

xbps-install -Syu

xbps-install -y curl wget fzf vim pass tmux xdg-user-dirs vifm age nerd-fonts kmscon fontconfig opendoas void-repo-nonfree tlp dbus linux linux-firmware-intel pipewire mpv gcc shellcheck make xz fastfetch chawan wireguard wireguard-tools ffmpeg smartmontools tealdeer tlp-rdw ncurses-term btrbk

xbps-reconfigure -fa

sudo -u "$SUDO_USER" xdg-user-dirs-update
fc-cache -fv

if [ ! -f /etc/doas.conf ]; then
	echo "permit persist keepenv :wheel as root" | tee /etc/doas.conf
	chmod 400 /etc/doas.conf
fi
