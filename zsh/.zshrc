# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY

# PATH
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.atuin/bin:$PATH"

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Atuin (better history)
eval "$(atuin init zsh)"

# FZF (fuzzy finder) keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Navi (cheatsheet manager)
bindkey '^G' navi

# Aliases (replace core utils with modern ones)
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first'
alias la='eza -lha --icons --group-directories-first'
alias cat='bat --style=plain --paging=never'
alias grep='rg'
alias find='fd'

# Git shortcuts
alias gs='git status'
alias gp='git pull'
alias gc='git commit'
alias gl='git log --oneline --graph --decorate'
alias lg='lazygit'

# Editor
export EDITOR=nvim

# Starship prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"


# asdf (version manager)
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
