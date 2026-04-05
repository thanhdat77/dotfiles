#!/usr/bin/env bash

echo "🔹 Updating system..."
sudo apt update || echo "⚠️ apt update failed, skipping..."

echo "🔹 Installing base packages..."
UBUNTU_VER=$(lsb_release -rs 2>/dev/null | cut -d. -f1)

# eza and zoxide are only in apt on Ubuntu 22.04+
if [ "${UBUNTU_VER:-0}" -ge 22 ] 2>/dev/null; then
  EXTRA_PKGS="eza zoxide"
else
  EXTRA_PKGS=""
fi

sudo apt install -y \
  git curl unzip zsh build-essential wget tmux \
  ripgrep fzf fd-find bat $EXTRA_PKGS ||
  echo "⚠️ some base packages failed"

# Fix Debian/Ubuntu renames (fd, bat)
if ! command -v fd &>/dev/null; then
  sudo ln -sf "$(which fdfind)" /usr/local/bin/fd || echo "⚠️ fd symlink failed"
fi
if ! command -v bat &>/dev/null; then
  sudo ln -sf "$(which batcat)" /usr/local/bin/bat || echo "⚠️ bat symlink failed"
fi

# Install eza manually on Ubuntu < 22
if ! command -v eza &>/dev/null; then
  echo "=== Installing eza (manual) ==="
  EZA_VER=$(curl -fsSL https://api.github.com/repos/eza-community/eza/releases/latest | grep tag_name | cut -d'"' -f4)
  curl -fsSLo /tmp/eza.tar.gz \
    "https://github.com/eza-community/eza/releases/download/${EZA_VER}/eza_x86_64-unknown-linux-musl.tar.gz" &&
    tar -xzf /tmp/eza.tar.gz -C /tmp &&
    sudo mv /tmp/eza /usr/local/bin/eza ||
    echo "⚠️ eza install failed"
fi

# Install zoxide manually on Ubuntu < 22
if ! command -v zoxide &>/dev/null; then
  echo "=== Installing zoxide (manual) ==="
  curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash ||
    echo "⚠️ zoxide install failed"
fi

echo "=== Installing Starship (POSIX sh) ==="
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

echo "=== Installing Oh-My-Zsh (SAFE MODE) ==="
RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ||
  echo "⚠️ oh-my-zsh install failed"

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

echo "Install atuin"
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
