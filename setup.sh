#!/bin/bash

# Symlink kitty configuration
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

# Symlink hyprland configuration
ln -sf ~/dotfiles/hyprland/hyprland.conf ~/.config/hyprland/hyprland.conf

echo "Dotfiles have been symlinked!"
