

# load env vars from .zprofile into the shells
[[ -f ~/.zprofile ]] && source ~/.zprofile

export ZSH="$HOME/.oh-my-zsh"
# zsh plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
  web-search
)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

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
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# --- Fd fallback ---
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    alias fd="fdfind"
fi

# --- Clipboard (WSL) ---
if command -v wl-copy >/dev/null 2>&1; then
    alias clip="wl-copy"
fi
#----- Vim Editing modes & keymaps ------ 
set -o vi

export EDITOR=nvim
export VISUAL=nvim

bindkey -M viins '^E' autosuggest-accept
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
#----------------------------------------
# -------------------ALIAS----------------------
# These alias need to have the same exact space as written here

# other Aliases shortcuts
alias c="clear"
alias e="exit"
alias vim="nvim"

# Tmux 
alias tmux="tmux -f $TMUX_CONF"
alias a="attach"
# calls the tmux new session script
alias tns="~/scripts/tmux-sessionizer"

# fzf 
# called from ~/scripts/
alias nlof="~/scripts/fzf_listoldfiles.sh"
# opens documentation through fzf (eg: git,zsh etc.)
alias fman="compgen -c | fzf | xargs man"

# zoxide (called from ~/scripts/)
alias nzo="~/scripts/zoxide_openfiles_nvim.sh"

# Next level of an ls 
# options :  --no-filesize --no-time --no-permissions 
alias ls="eza --no-filesize --long --color=always --icons=always --no-user" 

# tree
alias tree="tree -L 3 -a -I '.git' --charset X "
alias dtree="tree -L 3 -a -d -I '.git' --charset X "

# lstr
alias lstr="lstr --icons"

# git aliases
alias gt="git"
alias ga="git add ."
alias gs="git status -s"
alias gc='git commit -m'
alias glog='git log --oneline --graph --all'
alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'

alias nvim-scratch="NVIM_APPNAME=nvim-scratch nvim"

# lazygit
alias lg="lazygit"
# ---------------------------------------
