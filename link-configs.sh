#!/bin/bash

set -e

# List of configs to stow
CONFIGS=(
    "zsh"
    "tmux"
    "mise"
    "ghostty"
    "starship"
)

echo "==> Creating symlinks with stow..."

for config in "${CONFIGS[@]}"; do
    stow -R "$config"
    echo "    - Stowed $config"
done

echo "==> Symlinks created!"
