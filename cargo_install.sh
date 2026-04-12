#!/usr/bin/env bash

set -euo pipefail

VERBOSE="${VERBOSE:-0}"

say() { printf '%s\n' "$*"; }
log() { [ "$VERBOSE" = "1" ] && printf '%s\n' "$*" || true; }
have() { command -v "$1" >/dev/null 2>&1; }

UBUNTU_VER=$(lsb_release -rs 2>/dev/null | cut -d. -f1)
UBUNTU_VER=${UBUNTU_VER:-0}

say "== base packages"
sudo apt update || true
sudo apt install -y \
  git curl unzip zsh build-essential wget tmux || true

say "== rustup"
if ! have rustup; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Ensure cargo is available in this script session
if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck disable=SC1091
  source "$HOME/.cargo/env"
fi

if ! have cargo; then
  say "cargo not found after rustup install."
  say "Try: source \"$HOME/.cargo/env\" then re-run."
  exit 1
fi

rustup toolchain install stable >/dev/null 2>&1 || true
rustup default stable >/dev/null 2>&1 || true

say "== fzf"
if ! have fzf; then
  if [ "$UBUNTU_VER" -ge 20 ]; then
    sudo apt install -y fzf || true
  fi
  if ! have fzf; then
    log "Installing fzf (manual)..."
    if [ ! -d "$HOME/.fzf" ]; then
      git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    fi
    "$HOME/.fzf/install" --all --no-update-rc || true
  fi
fi

say "== zoxide"
if ! have zoxide; then
  if [ "$UBUNTU_VER" -ge 22 ]; then
    sudo apt install -y zoxide || true
  fi
  if ! have zoxide; then
    curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash || true
  fi
fi

say "== starship"
if ! have starship; then
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

say "== oh-my-zsh + plugins"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
fi

ZSH_DIR="$HOME/.oh-my-zsh"
if [ -d "$ZSH_DIR" ]; then
  mkdir -p "$ZSH_DIR/custom/plugins"
  [ -d "$ZSH_DIR/custom/plugins/zsh-vi-mode" ] || git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_DIR/custom/plugins/zsh-vi-mode"
  [ -d "$ZSH_DIR/custom/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_DIR/custom/plugins/zsh-autosuggestions"
  [ -d "$ZSH_DIR/custom/plugins/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_DIR/custom/plugins/zsh-syntax-highlighting"
  [ -d "$ZSH_DIR/custom/plugins/fzf-tab" ] || git clone https://github.com/Aloxaf/fzf-tab "$ZSH_DIR/custom/plugins/fzf-tab"
fi

say "== atuin"
if ! have atuin; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh || true
fi

say "== cargo tools"

# These are Rust-based tools you already use in this dotfiles repo.
# `cargo install` is idempotent-ish: it will error if already installed; we handle that gracefully.
cargo_install() {
  local crate="$1"
  # Note: binary names don't always match crate names (e.g. ripgrep -> rg).
  log "Installing $crate..."
  cargo install "$crate" || true
}

# Prefer cargo versions when you explicitly want Rustup/Cargo-managed tools.
cargo_install ripgrep
cargo_install fd-find
cargo_install bat
cargo_install eza
cargo_install broot

log ""
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

say "== link dotfiles"
# Canonical linking in this repo is `relink.sh` (direct symlinks).
if [ -x "$REPO_DIR/relink.sh" ]; then
  "$REPO_DIR/relink.sh" link
else
  say "relink.sh not found; falling back to stow"
  if ! have stow; then
    log "Installing stow (requires sudo)..."
    sudo apt update || true
    sudo apt install -y stow
  fi
  # Mirrors your README recommendations.
  stow -t "$HOME" zsh tmux starship yazi scripts
fi

say "== done"
say "Restart shell: exec zsh"
say "Broot shell function (optional): br --install"

