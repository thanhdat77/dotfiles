# ===== Environment =====

# Default editors
export EDITOR="nvim"
export VISUAL="nvim"

# History file path
export HISTFILE="$HOME/.zsh_history"

# Add local bin paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Cache directory for plugins or zsh temp files
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE_DIR"

