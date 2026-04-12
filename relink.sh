#!/usr/bin/env bash
#
# Canonical dotfiles linking via GNU Stow.
# Usage:
#   ./relink.sh            # unlink then link (restow)
#   ./relink.sh link       # stow (create symlinks)
#   ./relink.sh unlink     # unstow (remove symlinks)
#   STOW_PACKAGES="zsh tmux starship yazi scripts" ./relink.sh link
#   STOW_TARGET="$HOME" ./relink.sh link

set -euo pipefail

have() { command -v "$1" >/dev/null 2>&1; }

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_TARGET="${STOW_TARGET:-$HOME}"
# Mirrors README. Intentionally excludes `nvim` unless you opt in:
# your README notes nvim is often managed separately.
STOW_PACKAGES_DEFAULT="zsh tmux starship yazi scripts"
STOW_PACKAGES="${STOW_PACKAGES:-$STOW_PACKAGES_DEFAULT}"

ensure_stow() {
  if have stow; then
    return 0
  fi
  echo "stow not found. Install it first (recommended): sudo apt install -y stow" >&2
  exit 1
}

unlink_all() {
  ensure_stow
  echo "--- Unstowing ---"
  cd "$REPO_DIR"
  # shellcheck disable=SC2086
  stow -D -t "$STOW_TARGET" $STOW_PACKAGES
}

link_all() {
  ensure_stow
  echo "--- Stowing ---"
  cd "$REPO_DIR"
  # shellcheck disable=SC2086
  stow -S -t "$STOW_TARGET" $STOW_PACKAGES
}

case "$1" in
  unlink) unlink_all ;;
  link)   link_all ;;
  *)      unlink_all && link_all ;;
esac
