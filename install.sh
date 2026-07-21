#!/bin/sh

pkg install git doas curl wget fzf vis yash password-store tmux xdg-user-dirs todo yazi

xdg-user-dirs-update
echo "/usr/local/bin/yash" >> /etc/shells
chsh -s /usr/local/bin/yash

if [ -e "/var/log/console.log" ]; then
	touch /var/log/console.log
	chmod 600 /var/log/console.log
fi

if [ -e "/var/log/all.log" ]; then
	touch /var/log/all.log
	chmod 600 /var/log/all.log
fi

mkdir -p $HOME/tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/tmux/plugins
