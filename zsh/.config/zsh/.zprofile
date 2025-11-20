
export LANG=en_US.UTF-8
# Add local ~/scripts to the PATH
export PATH="$HOME/scripts:$PATH"
# Tmux
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"
# Starship PATH
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
# zsh thing
export ZSH="$HOME/.oh-my-zsh"

# ------------FZF--------------
# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# fzf preview for tmux
export FZF_TMUX_OPTS=" -p90%,70% "  
# -----------------------------

