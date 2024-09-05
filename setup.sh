#!/bin/bash

# Define the base directory of your dotfiles
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create symlinks for each config directory
ln -sfn "$DOTFILES_DIR/hypr" ~/.config/hypr
ln -sfn "$DOTFILES_DIR/kitty" ~/.config/kitty
ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim
ln -sfn "$DOTFILES_DIR/waybar" ~/.config/waybar

# Print a success message
echo "Symlinks created successfully."
