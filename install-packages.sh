#!/bin/bash

set -e

echo "==> Running package installation..."

# Nix packages
NIX_PACKAGES=(
  bat
  eza
  fd
  ripgrep
  lazygit
  yazi
  zoxide
  delta
  fzf
  neovim
  starship
  tmux
  mise
  unison
  fish
  stow
)

# Nix fonts
NIX_FONTS=(
  nerd-fonts.monaspace
)

echo "==> Installing CLI tools via Nix..."
installed=$(nix profile list | awk '/^Name:/ {print $2}')
for pkg in "${NIX_PACKAGES[@]}"; do
  if echo "$installed" | grep -qx "$pkg"; then
    echo "    - $pkg already installed"
  else
    echo "    - Installing $pkg"
    nix profile install "nixpkgs#$pkg"
  fi
done

echo "==> Installing fonts via Nix..."
for font in "${NIX_FONTS[@]}"; do
  font_name="${font##*.}"
  if echo "$installed" | grep -qx "$font_name"; then
    echo "    - $font already installed"
  else
    echo "    - Installing $font"
    nix profile install "nixpkgs#$font"
  fi
done

echo "==> Installing TPM (Tmux Plugin Manager)..."
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "    - TPM already installed"
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "    - TPM installed"
fi

echo "==> Installing Yazi rose-pine flavor..."
if command -v ya &> /dev/null; then
  if ya pkg list 2>/dev/null | grep -q "rose-pine"; then
    echo "    - Yazi rose-pine flavor already installed"
  else
    ya pkg add Mintass/rose-pine
    echo "    - Yazi rose-pine flavor installed"
  fi
else
  echo "    - Warning: 'ya' command not found, skipping yazi flavor installation"
fi

echo "==> Packages installed!"
