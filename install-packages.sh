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

echo "==> Packages installed!"
