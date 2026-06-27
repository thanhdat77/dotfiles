#!/usr/bin/env bash
# install.sh — Fresh machine setup: runs installs, stows dotfiles, syncs nvim
# Usage: bash setup/install.sh

set -euo pipefail

VERBOSE="${VERBOSE:-0}"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

say() { printf '\n\033[1;32m==\033[0m %s\n' "$*"; }
info() { printf '   %s\n' "$*"; }
log() { [ "$VERBOSE" = "1" ] && printf '   %s\n' "$*" || true; }
have() { command -v "$1" >/dev/null 2>&1; }

bash "$DOTFILES_DIR/setup/linux_install.sh"
bash "$DOTFILES_DIR/setup/cargo_install.sh"
bash "$DOTFILES_DIR/setup/update.sh"

# stow dotfiles
say "stow dotfiles"
cd "$DOTFILES_DIR"

STOW_LINKS=(
  "$HOME/.zshrc"
  "$HOME/.zprofile"
  "$HOME/.tmux.conf"
  "$HOME/.config/starship"
  "$HOME/.config/yazi"
  "$HOME/.config/sesh"
  "$HOME/.config/television"
  "$HOME/.config/atuin"
  "$HOME/.config/nvim"
  "$HOME/.config/lazygit/config.yml"
  "$HOME/.config/herdr/config.toml"
  "$HOME/custom_scripts"
)

bash "$DOTFILES_DIR/setup/backup_existing.sh" "${STOW_LINKS[@]}"

for link in "${STOW_LINKS[@]}"; do
  if [ -L "$link" ]; then
    rm "$link"
    log "Removed old symlink: $link"
  elif [ -f "$link" ]; then
    rm "$link"
    log "Removed old file: $link"
  fi
done

for pkg in zsh tmux starship yazi scripts atuin nvim sesh television lazygit herdr; do
  if stow -t "$HOME" "$pkg" 2>/dev/null; then
    info "stow $pkg — ok"
  else
    info "stow $pkg — FAILED (skipped)"
  fi
done

# nvim plugin sync
say "nvim plugin sync"
if have nvim; then
  info "Syncing lazy.nvim plugins..."
  nvim --headless "+Lazy! sync" +qa 2>&1 || true
fi

say "All done! Restart your shell: exec zsh"
