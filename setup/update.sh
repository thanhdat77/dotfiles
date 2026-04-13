#!/usr/bin/env bash
# update.sh — Check all tools, reinstall any that are missing or broken

set -euo pipefail

VERBOSE="${VERBOSE:-0}"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

say()    { printf '\n\033[1;32m==\033[0m %s\n' "$*"; }
ok()     { printf '   \033[1;32m✓\033[0m %s\n' "$*"; }
missing(){ printf '   \033[1;31m✗\033[0m %s — reinstalling...\n' "$*"; }
have()   { command -v "$1" >/dev/null 2>&1; }

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

UBUNTU_VER=$(lsb_release -rs 2>/dev/null | cut -d. -f1)
UBUNTU_VER=${UBUNTU_VER:-0}

say "checking linux tools"

# starship
if have starship; then ok "starship"; else
  missing "starship"
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

# fzf
if have fzf; then ok "fzf"; else
  missing "fzf"
  [ "$UBUNTU_VER" -ge 20 ] && sudo apt install -y fzf || true
  if ! have fzf; then
    [ ! -d "$HOME/.fzf" ] && git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all --no-update-rc || true
  fi
fi

# zoxide
if have zoxide; then ok "zoxide"; else
  missing "zoxide"
  [ "$UBUNTU_VER" -ge 22 ] && sudo apt install -y zoxide || true
  have zoxide || curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash || true
fi

# neovim
if have nvim; then ok "nvim"; else
  missing "nvim"
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" -o /tmp/nvim.tar.gz
  sudo tar -C /opt -xzf /tmp/nvim.tar.gz && rm /tmp/nvim.tar.gz
fi

# sesh
if have sesh; then ok "sesh"; else
  missing "sesh"
  curl -fsSL "https://github.com/joshmedeski/sesh/releases/latest/download/sesh_Linux_x86_64.tar.gz" -o /tmp/sesh.tar.gz
  sudo tar -C /usr/local/bin -xzf /tmp/sesh.tar.gz sesh && rm /tmp/sesh.tar.gz
fi

say "checking cargo tools"

if ! have cargo; then
  missing "cargo/rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  ok "cargo"
fi

for pkg in ripgrep fd-find bat eza broot atuin yazi-fm yazi-cli; do
  # map crate name to binary name for the check
  case "$pkg" in
    ripgrep)  bin="rg"    ;;
    fd-find)  bin="fd"    ;;
    yazi-fm)  bin="yazi"  ;;
    yazi-cli) bin="ya"    ;;
    *)        bin="$pkg"  ;;
  esac

  if have "$bin"; then ok "$pkg ($bin)"; else
    missing "$pkg"
    cargo install "$pkg" || true
  fi
done

say "all checks done"
