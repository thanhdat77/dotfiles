#!/usr/bin/env bash
# linux_install.sh — Install system packages, shell, and binaries
# Stages: 1) apt  2) oh-my-zsh  3) prompt/tools  4) GitHub binaries

set -euo pipefail

VERBOSE="${VERBOSE:-0}"

say()  { printf '\n\033[1;32m==\033[0m %s\n' "$*"; }
info() { printf '   %s\n' "$*"; }
log()  { [ "$VERBOSE" = "1" ] && printf '   %s\n' "$*" || true; }
have() { command -v "$1" >/dev/null 2>&1; }

UBUNTU_VER=$(lsb_release -rs 2>/dev/null | cut -d. -f1)
UBUNTU_VER=${UBUNTU_VER:-0}

# base packages
say "STAGE 1: base packages"
sudo apt update -qq || true
sudo apt install -y git curl unzip wget zsh build-essential tmux stow || true

# oh-my-zsh + plugins
say "STAGE 2: shell"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
fi

ZSH_PLUGINS="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS"
[ -d "$ZSH_PLUGINS/zsh-vi-mode" ]             || git clone https://github.com/jeffreytse/zsh-vi-mode            "$ZSH_PLUGINS/zsh-vi-mode"
[ -d "$ZSH_PLUGINS/zsh-autosuggestions" ]     || git clone https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_PLUGINS/zsh-autosuggestions"
[ -d "$ZSH_PLUGINS/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_PLUGINS/zsh-syntax-highlighting"
[ -d "$ZSH_PLUGINS/fzf-tab" ]                 || git clone https://github.com/Aloxaf/fzf-tab                    "$ZSH_PLUGINS/fzf-tab"

# starship, fzf, zoxide
say "STAGE 3: prompt & shell tools"
if ! have starship; then
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

if ! have fzf; then
  [ "$UBUNTU_VER" -ge 20 ] && sudo apt install -y fzf || true
  if ! have fzf; then
    [ ! -d "$HOME/.fzf" ] && git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all --no-update-rc || true
  fi
fi

if ! have zoxide; then
  [ "$UBUNTU_VER" -ge 22 ] && sudo apt install -y zoxide || true
  if ! have zoxide; then
    curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash || true
  fi
fi

# neovim, sesh
say "STAGE 4: binary installs"
if ! have nvim; then
  info "Installing neovim..."
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" -o /tmp/nvim.tar.gz
  sudo tar -C /opt -xzf /tmp/nvim.tar.gz
  rm /tmp/nvim.tar.gz
fi

if ! have sesh; then
  info "Installing sesh..."
  curl -fsSL "https://github.com/joshmedeski/sesh/releases/latest/download/sesh_Linux_x86_64.tar.gz" -o /tmp/sesh.tar.gz
  sudo tar -C /usr/local/bin -xzf /tmp/sesh.tar.gz sesh
  rm /tmp/sesh.tar.gz
fi

if ! have yazi; then
  info "Installing yazi..."
  curl -fsSL "https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip" -o /tmp/yazi.zip
  unzip -q /tmp/yazi.zip -d /tmp/yazi-extracted
  sudo mv /tmp/yazi-extracted/yazi-*/yazi /usr/local/bin/
  sudo mv /tmp/yazi-extracted/yazi-*/ya /usr/local/bin/
  rm -rf /tmp/yazi.zip /tmp/yazi-extracted
fi

say "linux done"
