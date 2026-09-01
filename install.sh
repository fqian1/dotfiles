#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "Must be run as super user"
	return 1
fi

xbps-install -Syu

xbps-install -y curl wget fzf vim pass tmux xdg-user-dirs vifm age nerd-fonts kmscon fontconfig opendoas void-repo-nonfree intel-ucode tlp dbus linux linux-firmware-intel pipewire mpv gcc shellcheck make xz fastfetch chawan wireguard wireguard-tools ffmpeg smartmontools tealdeer tlp-rdw

xbps-reconfigure -fa

xdg-user-dirs-update
fc-cache -fv
