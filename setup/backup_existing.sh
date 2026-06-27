#!/usr/bin/env bash
# backup_existing.sh — copy existing non-symlink config paths before stow deletes them

set -euo pipefail

BACKUP_ROOT="${BACKUP_ROOT:-$HOME/.dotfiles-backup}"
STAMP="${BACKUP_STAMP:-$(date +%Y%m%d-%H%M%S)}"
BACKUP_DIR="$BACKUP_ROOT/$STAMP"
made=0

for path in "$@"; do
  [ -e "$path" ] || continue
  [ ! -L "$path" ] || continue

  if [ "$made" -eq 0 ]; then
    if [ -e "$BACKUP_DIR" ]; then
      BACKUP_DIR="$BACKUP_ROOT/$STAMP-$$"
    fi
    mkdir -p "$BACKUP_DIR"
    made=1
  fi

  rel="${path#$HOME/}"
  mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
  cp -a "$path" "$BACKUP_DIR/$rel"
done

if [ "$made" -eq 1 ]; then
  printf 'Backed up existing config to %s\n' "$BACKUP_DIR"
fi
