

# load env vars from .zprofile into the shells
[[ -f ~/.zprofile ]] && source ~/.zprofile

export ZSH="$HOME/.oh-my-zsh"
# zsh plugins
plugins=(
  git
  zsh-vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
  web-search
)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# --- Zoxide ---
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd="z"
    alias nocd="cd"
fi

# --- FZF (bindings + completion) ---
if command -v fzf >/dev/null 2>&1; then
    # Debian/Ubuntu path
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
fi

# --- Sesh completion ---
if command -v sesh >/dev/null 2>&1; then
    mkdir -p ~/.zsh/completions
    sesh completion zsh > ~/.zsh/completions/_sesh
    fpath=(~/.zsh/completions $fpath)
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
    export BAT_THEME="OneHalfLight"
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

# ----- Vi mode (zsh-vi-mode plugin) -----
# Plugin is loaded by Oh-My-Zsh via `plugins=(... zsh-vi-mode ...)`.
# Keep these settings ABOVE any `bindkey` calls that should apply after vi-mode.
#
# Optional: allow `jk` to exit insert mode quickly.
ZVM_VI_INSERT_ESCAPE_BINDKEY='ff'
# Optional: show mode changes in the prompt faster (reduces lag with heavy prompts).
ZVM_REFRESH_PROMPT_ON_MODE_CHANGE=true

export EDITOR=nvim
export VISUAL=nvim

# Insert-mode bindings (these work nicely alongside zsh-autosuggestions)
bindkey -M viins '^E' autosuggest-accept
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
#-----------------------------------------
# -------------------ALIAS----------------------
# These alias need to have the same exact space as written here

# other Aliases shortcuts
alias c="clear"
alias e="exit"
alias vim="nvim"

export TMUX_CONF="$HOME/.tmux.conf"
# Tmux
alias tmux="tmux -f $TMUX_CONF"
# Keep tmux pane_current_path in sync with shell CWD
[[ -n "$TMUX" ]] && precmd() { tmux refresh-client -S 2>/dev/null; }
alias a="attach"
# sesh - smart session switcher (zoxide-aware)
alias st="~/custom_scripts/sesh-smart-connect"

# opens documentation through fzf (eg: git,zsh etc.)
alias fman="compgen -c | fzf | xargs man"
alias nf="~/custom_scripts/nvim-find-file"
alias nr="~/custom_scripts/nvim-find-content"

alias ld="lazydocker"

# Next level of an ls 
# options :  --no-filesize --no-time --no-permissions 
alias ls="eza --no-filesize --long --color=always --icons=always --no-user -la" 

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
alias gcam="git commit --amend --no-edit"
alias glog='git log --oneline --graph --all'
alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'

alias nvim-scratch="NVIM_APPNAME=nvim-scratch nvim"

# lazygit
alias lg="lazygit"

# docker aliases
alias dk="sudo docker"
alias dkc="sudo docker compose"
alias dkcu="sudo docker compose up -d"
alias dkcd="sudo docker compose down"
alias dkcr="sudo docker compose restart"
alias dkl="sudo docker logs -fn 1111"       # dkl <container>
alias dkps="sudo docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.CreatedAt}}\t{{.Image}}'"
alias dkpsa="sudo docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.CreatedAt}}\t{{.Image}}'"
alias dkex="sudo docker exec -it"         # dkex <container> bash
alias dkrm="sudo docker rm -f"            # dkrm <container>
alias dkimg="sudo docker images"
alias dkprune="sudo docker system prune -af --volumes"
alias nvim-ks='NVIM_APPNAME="nvim-ks" nvim'
# ---------------------------------------
[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"

# --- Atuin (shell history) ---
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- Broot ---
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"
