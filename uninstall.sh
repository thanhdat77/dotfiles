#!/usr/bin/env bash

set -euo pipefail

log() { printf '%s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

# Safe-by-default:
# - Removes user-level installs created by install scripts (rustup/cargo, oh-my-zsh, fzf git install, atuin, etc.)
# - DOES NOT remove apt packages unless you set REMOVE_APT=1
REMOVE_APT="${REMOVE_APT:-0}"
# Default to removing stowed symlinks (fresh wipe expectation).
PURGE_STOW_LINKS="${PURGE_STOW_LINKS:-1}"

log "=== dotfiles uninstall (fresh wipe) ==="
log "REMOVE_APT=$REMOVE_APT (set to 1 to remove apt packages too)"
log "PURGE_STOW_LINKS=$PURGE_STOW_LINKS (set to 1 to delete stowed symlinks)"
log ""

log "=== Stop if running inside sudo ==="
if [ "${EUID:-$(id -u)}" -eq 0 ]; then
  log "Please run as a regular user (not root)."
  exit 1
fi

log ""
log "=== Remove Oh-My-Zsh + custom plugins ==="
if [ -d "$HOME/.oh-my-zsh" ]; then
  rm -rf "$HOME/.oh-my-zsh"
  log "Removed: ~/.oh-my-zsh"
fi

log ""
log "=== Remove fzf git install ==="
if [ -d "$HOME/.fzf" ]; then
  rm -rf "$HOME/.fzf"
  log "Removed: ~/.fzf"
fi

log ""
log "=== Remove Atuin ==="
# Atuin installs vary; remove common locations.
rm -rf "$HOME/.atuin" 2>/dev/null || true
rm -f "$HOME/.atuin/bin/env" 2>/dev/null || true
rm -f "$HOME/.local/share/atuin" 2>/dev/null || true
rm -f "$HOME/.local/bin/atuin" 2>/dev/null || true

log ""
log "=== Remove Rustup / Cargo (user install) ==="
rm -rf "$HOME/.rustup" "$HOME/.cargo" 2>/dev/null || true

log ""
log "=== Remove Starship (user install) ==="
rm -f "$HOME/.local/bin/starship" 2>/dev/null || true

log ""
log "=== Remove Zoxide (user install) ==="
rm -f "$HOME/.local/bin/zoxide" 2>/dev/null || true

log ""
log "=== Remove broot launcher files (user) ==="
rm -rf "$HOME/.local/share/broot" 2>/dev/null || true
rm -rf "$HOME/.config/broot/launcher" 2>/dev/null || true
rm -f "$HOME/.config/fish/functions/br.fish" 2>/dev/null || true

log ""
log "=== Remove stowed symlinks ==="
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

unlink_if_points_into_repo() {
  local path="$1"
  if [ -L "$path" ]; then
    local target
    target="$(readlink "$path" || true)"
    case "$target" in
      "$REPO_DIR"/*)
        rm -f "$path"
        log "Unlinked: $path -> $target"
        ;;
      *)
        log "Skipping (not from dotfiles): $path -> $target"
        ;;
    esac
  fi
}

if [ "$PURGE_STOW_LINKS" = "1" ]; then
  # Prefer stow -D (handles directories), but fall back to safe symlink unlinking.
  if ! have stow; then
    log "stow not found; installing stow to unstow links..."
    sudo apt update || true
    sudo apt install -y stow || true
  fi

  if have stow; then
    cd "$REPO_DIR"
    stow -D -t "$HOME" zsh tmux starship yazi scripts || true
    log "Unstowed (via stow): zsh tmux starship yazi scripts"
  else
    log "stow still not available; unlinking common stow targets safely..."
    unlink_if_points_into_repo "$HOME/.zshrc"
    unlink_if_points_into_repo "$HOME/.tmux.conf"
    unlink_if_points_into_repo "$HOME/.config/starship/starship.toml"
    unlink_if_points_into_repo "$HOME/.config/yazi"
    unlink_if_points_into_repo "$HOME/custom_scripts"
  fi
else
  log "Skipping unstow. (Set PURGE_STOW_LINKS=1 to enable.)"
fi

log ""
log "=== Optionally remove apt packages ==="
if [ "$REMOVE_APT" = "1" ]; then
  # This is intentionally conservative; it removes packages your installer explicitly installed.
  # It will not remove dependencies that are still required by other packages.
  sudo apt remove -y \
    zsh tmux git curl unzip build-essential wget \
    ripgrep fzf fd-find bat eza zoxide stow || true
  sudo apt autoremove -y || true
  log "Apt packages removal attempted."
else
  log "Skipping apt package removal. (Set REMOVE_APT=1 to enable.)"
fi

log ""
log "Done."
log "You may want to restart your shell: exec bash (or close/reopen terminal)"

