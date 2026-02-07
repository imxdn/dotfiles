#!/bin/bash

set -e

echo "==> Starting dotfiles setup..."
echo

./install-packages.sh
echo

./link-configs.sh
echo

# Add zshrc source line if not present
echo "==> Configuring .zshrc..."
if ! grep -q "source ~/.config/zsh/init.zsh" ~/.zshrc 2>/dev/null; then
    echo "source ~/.config/zsh/init.zsh" >> ~/.zshrc
    echo "    - Added source line to ~/.zshrc"
else
    echo "    - Source line already exists in ~/.zshrc"
fi

echo
echo "==> Setup complete! Restart your shell."
