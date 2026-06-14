

# load env vars from .zprofile into the shells
[[ -f ~/.zprofile ]] && source ~/.zprofile

export ZSH="$HOME/.oh-my-zsh"

# Must be set BEFORE oh-my-zsh loads zsh-vi-mode plugin
ZVM_VI_INSERT_ESCAPE_BINDKEY='wf'
ZVM_REFRESH_PROMPT_ON_MODE_CHANGE=true

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

# if command -v tv >/dev/null 2>&1; then
#   eval "$(tv init zsh)"
# fi

autoload zmv
#example zmv '(*).log' '$1.txt' or zmv -W '*.log' '*.txt'| there is -i -n

# Ctrl-T → queue sesh command, then run it as a normal shell command.
# This avoids running TUI directly inside the ZLE widget.
function _queue_sesh_cmd() {
  BUFFER="$HOME/custom_scripts/sesh-zsh-picker"
  zle accept-line
}
zle -N _queue_sesh_cmd

export EDITOR=nvim
export VISUAL=nvim

function zvm_after_init() {
  bindkey -M emacs "^T" _queue_sesh_cmd
  bindkey -M viins "^T" _queue_sesh_cmd
  bindkey -M vicmd "^T" _queue_sesh_cmd
  if zle -l fzf-file-widget >/dev/null 2>&1; then
    bindkey -M emacs "^F" fzf-file-widget
    bindkey -M viins "^F" fzf-file-widget
    bindkey -M vicmd "^F" fzf-file-widget
  fi
  bindkey -M viins "^E" autosuggest-accept
  bindkey -M viins "^P" up-line-or-history
  bindkey -M viins "^N" forward-word
  bindkey -M emacs "^R" atuin-search
  bindkey -M viins "^R" atuin-search-viins
}

# zsh-vi-mode is loaded by oh-my-zsh before this function is defined,
# so apply the bindings explicitly as well.
[[ -o interactive ]] && zvm_after_init
#-----------------------------------------
# -------------------ALIAS----------------------
# These alias need to have the same exact space as written here
# global
alias -g NE='2>/dev/null'
alias -g B='| bat --wrap=never' 
# subfix
alias -s sh='bash' 
# other Aliases shortcuts
alias c="clear"
alias e="exit"
alias vim="nvim"

export TMUX_CONF="$HOME/.tmux.conf"
# Tmux
alias tmux="tmux -f $TMUX_CONF"
# Keep tmux pane_current_path in sync with shell CWD.
# Special case: show full ssh command in the tmux window name while ssh is running.
autoload -Uz add-zsh-hook

_tmux_window_name_for_command() {
  [[ -z "$TMUX" ]] && return

  local cmd="$1"
  if [[ "$cmd" == ssh\ * ]]; then
    tmux set-window-option -q automatic-rename off 2>/dev/null
    tmux set-window-option -q @ssh_window_name active 2>/dev/null
    tmux rename-window "${cmd}" 2>/dev/null
  fi
}

_tmux_window_name_for_prompt() {
  [[ -z "$TMUX" ]] && return

  tmux refresh-client -S 2>/dev/null

  if [[ "$(tmux show-window-option -qv @ssh_window_name 2>/dev/null)" == "active" ]]; then
    tmux set-window-option -qu @ssh_window_name 2>/dev/null
    tmux set-window-option -q automatic-rename on 2>/dev/null
  fi
}

add-zsh-hook preexec _tmux_window_name_for_command
add-zsh-hook precmd _tmux_window_name_for_prompt
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
alias lstr="eza --tree --level=2 --icons=always --group-directories-first ."

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

# pnpm
export PNPM_HOME="/home/fenix/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# opencode
export PATH=/home/fenix/.opencode/bin:$PATH
