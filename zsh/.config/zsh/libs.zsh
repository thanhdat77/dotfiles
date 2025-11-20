# ===== Library / Tool initializers =====

# --- Zoxide ---
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# --- FZF (bindings + completion) ---
if command -v fzf >/dev/null 2>&1; then
    # Debian/Ubuntu path
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
fi

# --- Starship prompt ---
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# --- Eza (better ls) ---
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons"
    alias ll="eza -lha --icons"
fi

# --- Bat (theme support) ---
if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="Catppuccin-mocha"
fi

# --- Add Neovim (AppImage extract) ---
export PATH="/usr/local/nvim/usr/bin:$PATH"

# --- Fd fallback ---
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    alias fd="fdfind"
fi

# --- Clipboard (WSL) ---
if command -v wl-copy >/dev/null 2>&1; then
    alias clip="wl-copy"
fi

