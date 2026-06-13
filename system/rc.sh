#!bin/sh

cp "$(chezmoi source-path)/system/rc.conf" /etc/
doas chown root:wheel /etc/rc.conf
doas chmod 644 /etc/rc.conf
