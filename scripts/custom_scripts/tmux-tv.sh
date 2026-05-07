# tmux window switcher via television
tw() {
  local win
  win=$(tv tmux-windows </dev/tty)
  [[ -n "$win" ]] && tmux switch-client -t "$win"
}

# television: intercept update-channels to re-link custom cables from dotfiles
tv() {
  command tv "$@"
  if [[ "$1" == "update-channels" ]]; then
    local cable_dir="$HOME/.config/television/cable"
    local dotfiles_cable="$HOME/dotfiles/television/.config/television/cable"
    for f in "$dotfiles_cable"/*.toml; do
      ln -sf "$f" "$cable_dir/$(basename "$f")"
    done
  fi
}