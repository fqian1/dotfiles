#!/bin/sh

doas cp "$(chezmoi source-path)/system/doas.conf" /usr/local/etc/doas.conf"
doas chown root:wheel /usr/local/etc/doas.conf
doas chmod 0600 /usr/local/etc/doas.conf
