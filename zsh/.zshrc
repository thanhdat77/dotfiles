# --- Ensure per-user zsh config directory exists ---
if [[ ! -d "$HOME/.config/zsh" ]]; then
  mkdir -p "$HOME/.config/zsh"
fi

# --- Load all modular config files from ~/.config/zsh ---
for config_file in "$HOME/.config/zsh"/*.zsh; do
  [ -r "$config_file" ] && source "$config_file"
done

# --- Basic guard: don't run interactive-only stuff when shell is not interactive ---
if [[ $- == *i* ]]; then
  # Starship prompt (interactive only)
  if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
  fi
fi

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
