#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"

declare -A LINKS=(
  ["$DOTFILES/zsh/.zshrc"]="$HOME/.zshrc"
  ["$DOTFILES/tmux/.tmux.conf"]="$HOME/.tmux.conf"
  ["$DOTFILES/nvim/.config/nvim"]="$HOME/.config/nvim"
  ["$DOTFILES/starship/.config/starship"]="$HOME/.config/starship"
  ["$DOTFILES/yazi/.config/yazi"]="$HOME/.config/yazi"
  ["$DOTFILES/scripts/custom_scripts"]="$HOME/custom_scripts"
)

unlink_all() {
  echo "--- Unlinking ---"
  for src in "${!LINKS[@]}"; do
    target="${LINKS[$src]}"
    if [ -L "$target" ]; then
      rm "$target"
      echo "  removed: $target"
    else
      echo "  skip (not a symlink): $target"
    fi
  done
}

link_all() {
  echo "--- Linking ---"
  for src in "${!LINKS[@]}"; do
    target="${LINKS[$src]}"
    mkdir -p "$(dirname "$target")"
    ln -sf "$src" "$target"
    echo "  linked: $target -> $src"
  done
}

case "$1" in
  unlink) unlink_all ;;
  link)   link_all ;;
  *)      unlink_all && link_all ;;
esac
