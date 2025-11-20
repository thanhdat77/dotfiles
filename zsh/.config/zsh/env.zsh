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
# ================================
# Environment & PATH
# ================================
export EDITOR=nvim
export VISUAL=nvim

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

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

# gdircolors (optional)
command -v gdircolors &>/dev/null && eval "$(gdircolors)"


# ================================
# Zsh Options
# ================================
bindkey -v        # vi mode
set -o vi
bindkey -r "^G"   # unbind ctrl-g

# Disable less pipe
export LESS="-R"
export PAGER="less"




# Atuin
export ATUIN_NOBIND="true"
command -v atuin &>/dev/null && eval "$(atuin init zsh)"

# Scripts (fzf git)
[[ -f "$HOME/scripts/fzf-git.sh" ]] && source "$HOME/scripts/fzf-git.sh"

# ZSH plugins (oh-my-zsh optional)
[[ -n "$ZSH" ]] && source "$ZSH/oh-my-zsh.sh"

# Syntax Highlight (Brew)
command -v brew &>/dev/null && \
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Deno
[[ -f "$HOME/.deno/env" ]] && source "$HOME/.deno/env"


# ================================
# Keybinds
# ================================
bindkey -M viins '^E' autosuggest-accept
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey '^r' atuin-up-search-viins


# ================================
# Aliases
# ================================

alias c="clear"
alias e="exit"
alias vim="nvim"

# Git
alias gt="git"
alias ga="git add ."
alias gs="git status -s"
alias gc='git commit -m'
alias glog='git log --oneline --graph --all'

# LazyGit
alias lg="lazygit"

# EZA (LS)
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"
alias tree="tree -L 3 -a -I '.git' --charset X"
alias dtree="tree -L 3 -a -d -I '.git' --charset X"

# Tmux
alias tmux="tmux -f $TMUX_CONF"
alias a="attach"
alias tns="~/scripts/tmux-sessionizer"

# FZF scripts
alias nlof="~/scripts/fzf_listoldfiles.sh"
alias fman="compgen -c | fzf | xargs man"

# Zoxide helper
alias nzo="~/scripts/zoxide_openfiles_nvim.sh"

alias nvim-scratch="NVIM_APPNAME=nvim-scratch nvim"
