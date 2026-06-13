#!/bin/sh
# Remember to tell rc.conf to use "my.kbd"

doas ln -sf "$(chezmoi source-path)/dotfiles/keymaps/my.kbd" /usr/share/vt/keymaps/my.kbd

