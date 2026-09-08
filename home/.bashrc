# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# automatically install ble.sh
__blesh_dir="$HOME/.local/share/blesh"
if [[ ! -d "$__blesh_dir" ]]; then
    echo "Installing ble.sh nightly..."
    curl -sL https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar -xJf - -C /tmp
    mkdir -p "$(dirname "$__blesh_dir")"
    mv /tmp/ble-nightly "$__blesh_dir"
fi

[[ $- == *i* ]] && source -- "$__blesh_dir"/ble.sh --attach=none
# .bashrc contents here:

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

bind 'set keyseq-timeout 1'

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s globstar
shopt -s extglob

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f $HOME/.shrc ]; then
	. $HOME/.shrc
fi

# Keep this line at the end
[[ ! ${BLE_VERSION-} ]] || ble-attach
