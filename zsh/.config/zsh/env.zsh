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


# ================================
# Plugins / Initializers
# ================================

# Starship
if command -v starship &>/dev/null; then
    # prevent starship zle bug
    if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
          "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
        zle -N zle-keymap-select ""
    fi
    eval "$(starship init zsh)"
fi

# Zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# FZF for Ubuntu / WSL
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
    source /usr/share/doc/fzf/examples/completion.zsh
fi

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
