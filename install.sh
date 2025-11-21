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
sudo apt install -y zsh git curl wget tmux build-essential unzip ripgrep fzf

echo "=== Installing Starship (POSIX sh) ==="
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

echo "=== Installing Oh-My-Zsh (SAFE MODE) ==="
RUNZSH=no KEEP_ZSHRC=yes \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  || echo "⚠️ oh-my-zsh install failed"

ZSH_DIR="$HOME/.oh-my-zsh"

echo "=== Installing Zsh Plugins ==="
# zsh-autosuggestions
if [ ! -d "$ZSH_DIR/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_DIR/custom/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_DIR/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_DIR/custom/plugins/zsh-syntax-highlighting"
fi

# fzf-tab (optional, super nice)
if [ ! -d "$ZSH_DIR/custom/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab \
    "$ZSH_DIR/custom/plugins/fzf-tab"
fi
# install yazi 
sh ./scripts/install_yazi.sh
