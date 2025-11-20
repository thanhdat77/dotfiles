# ===== Zsh Options =====

# --- History ---
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"
setopt inc_append_history        # append instead of overwrite
setopt share_history             # share between terminals

# --- UI / Editing ---
setopt autocd                    # cd by typing folder name
setopt interactivecomments       # allow # comments in interactive mode
setopt correct                   # autocorrect mistyped commands
setopt promptsubst               # allow $(...) and variables in prompt

# --- Pattern matching ---
setopt extendedglob

# --- Completion ---
autoload -U compinit
compinit -u

# Make completion list nicer
zstyle ':completion:*:default' menu select
