#!/bin/sh

SHELL_PATH="/usr/local/bin/yash"

if [ "$SHELL" != "$SHELL_PATH" ]; then 
    echo "Setting shell to $SHELL_PATH..."
    chsh -s "$SHELL_PATH"
fi
