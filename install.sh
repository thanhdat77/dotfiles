#!/usr/bin/env bash

echo "🔹 Updating system..."
sudo apt update || echo "⚠️ apt update failed, skipping..."

echo "🔹 Installing base packages..."
sudo apt install -y \
  git curl unzip zsh build-essential \
  ripgrep fzf fd-find bat eza zoxide \
  just || echo "⚠️ some base packages failed"

# Fix Debian renames (fd, bat)
if ! command -v fd &>/dev/null; then
  sudo ln -sf $(which fdfind) /usr/local/bin/fd || echo "⚠️ fd symlink failed"
fi
if ! command -v bat &>/dev/null; then
  sudo ln -sf $(which batcat) /usr/local/bin/bat || echo "⚠️ bat symlink failed"
fi
echo "=== Installing essentials ==="
sudo apt install -y zsh git curl wget tmux neovim build-essential unzip ripgrep fzf

echo "=== Installing Starship (POSIX sh) ==="
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

