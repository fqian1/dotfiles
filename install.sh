#!/bin/sh

xbps-install -Syu
xbps-install -y git opendoas curl wget fzf vim bash password-store tmux xdg-user-dirs yazi age nerd-fonts kmscon
xbps-reconfigure -fa

xdg-user-dirs-update

fc-cache -fv
