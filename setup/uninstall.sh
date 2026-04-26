#!/usr/bin/env bash
# uninstall.sh — Unlink dotfiles, remove cargo packages, remove binaries

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

say() { printf '\n\033[1;31m==\033[0m %s\n' "$*"; }
info() { printf '   %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

# unstow dotfiles
say "unstow dotfiles"
cd "$DOTFILES_DIR"
stow -D -t "$HOME" zsh tmux starship yazi scripts atuin nvim 2>/dev/null || true
info "Symlinks removed."

# cargo packages
say "remove cargo packages"
if have cargo; then
  for pkg in ripgrep fd-find bat eza broot atuin yazi-fm yazi-cli; do
    cargo uninstall "$pkg" 2>/dev/null && info "Removed $pkg" || true
  done
fi

# rustup
say "remove rustup"
if have rustup; then
  rustup self uninstall -y || true
fi

# binaries (GitHub releases)
say "remove binaries"
sudo rm -rf /opt/nvim-linux-x86_64 && info "Removed neovim" || true
sudo rm -f /usr/local/bin/sesh && info "Removed sesh" || true

say "uninstall done"
