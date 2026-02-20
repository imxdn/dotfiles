#!/bin/bash

set -e

echo "==> Running package installation..."

# Update mode
if [ "$1" = "update" ]; then
  echo "==> Updating nix flake..."
  nix flake update --flake ~/.dotfiles
  nix profile upgrade '.*'
  echo "==> Updating mise..."
  mise self-update
  echo "==> Updates complete!"
  exit 0
fi

echo "==> Installing packages via Nix flake..."
if nix profile list | grep -q "dotfiles-packages"; then
  echo "    - Nix packages already installed"
else
  nix profile install ~/.dotfiles
fi

echo "==> Installing mise..."
if [ -f "$HOME/.local/bin/mise" ]; then
  echo "    - mise already installed"
else
  curl https://mise.run | sh
  echo "    - mise installed"
fi

echo "==> Installing TPM (Tmux Plugin Manager)..."
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "    - TPM already installed"
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "    - TPM installed"
fi

echo "==> Installing Yazi ayu-dark flavor..."
if command -v ya &> /dev/null; then
  if ya pkg list 2>/dev/null | grep -q "ayu-dark"; then
    echo "    - Yazi ayu-dark flavor already installed"
  else
    ya pkg add BennyOe/ayu-dark
    echo "    - Yazi ayu-dark flavor installed"
  fi
else
  echo "    - Warning: 'ya' command not found, skipping yazi flavor installation"
fi

echo "==> Packages installed!"
