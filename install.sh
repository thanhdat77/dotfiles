#!/usr/bin/env bash

set -euo pipefail

UBUNTU_VER=$(lsb_release -rs 2>/dev/null | cut -d. -f1)
UBUNTU_VER=${UBUNTU_VER:-0}

echo "🔹 Detected Ubuntu ${UBUNTU_VER}"
echo "🔹 Updating system..."
sudo apt update || echo "⚠️ apt update failed, skipping..."

# ─── Helpers ──────────────────────────────────────────────────────────────────

install_binary_from_gh() {
  # Usage: install_binary_from_gh <owner/repo> <url_pattern> <binary_name_in_archive> [strip_components]
  local repo="$1" url_pattern="$2" bin_name="$3" strip="${4:-0}"
  local ver
  ver=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" |
    grep tag_name | cut -d'"' -f4)
  local url="${url_pattern/VERSION/$ver}"
  echo "  Downloading ${bin_name} ${ver} from ${url}..."
  curl -fsSLo /tmp/_install.tar.gz "$url"
  tar -xzf /tmp/_install.tar.gz -C /tmp --strip-components="$strip"
  sudo mv "/tmp/${bin_name}" /usr/local/bin/
  rm -f /tmp/_install.tar.gz
}

# ─── Base packages always available ───────────────────────────────────────────

echo "🔹 Installing base packages (always in apt)..."
sudo apt install -y \
  git curl unzip zsh build-essential wget tmux || echo "⚠️ some base packages failed"

# ─── ripgrep ──────────────────────────────────────────────────────────────────

if ! command -v rg &>/dev/null; then
  if [ "$UBUNTU_VER" -ge 19 ]; then
    sudo apt install -y ripgrep || true
  fi
  if ! command -v rg &>/dev/null; then
    echo "=== Installing ripgrep (manual) ==="
    install_binary_from_gh \
      "BurntSushi/ripgrep" \
      "https://github.com/BurntSushi/ripgrep/releases/download/VERSION/ripgrep-VERSION-x86_64-unknown-linux-musl.tar.gz" \
      "rg" 1 || echo "⚠️ ripgrep install failed"
  fi
fi

# ─── fzf ──────────────────────────────────────────────────────────────────────

if ! command -v fzf &>/dev/null; then
  if [ "$UBUNTU_VER" -ge 20 ]; then
    sudo apt install -y fzf || true
  fi
  if ! command -v fzf &>/dev/null; then
    echo "=== Installing fzf (manual) ==="
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-update-rc || echo "⚠️ fzf install failed"
  fi
fi

# ─── fd ───────────────────────────────────────────────────────────────────────

if ! command -v fd &>/dev/null; then
  if [ "$UBUNTU_VER" -ge 19 ]; then
    sudo apt install -y fd-find || true
    sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd 2>/dev/null || true
  fi
  if ! command -v fd &>/dev/null; then
    echo "=== Installing fd (manual) ==="
    install_binary_from_gh \
      "sharkdp/fd" \
      "https://github.com/sharkdp/fd/releases/download/VERSION/fd-VERSION-x86_64-unknown-linux-musl.tar.gz" \
      "fd" 1 || echo "⚠️ fd install failed"
  fi
fi

# ─── bat ──────────────────────────────────────────────────────────────────────

if ! command -v bat &>/dev/null; then
  if [ "$UBUNTU_VER" -ge 20 ]; then
    sudo apt install -y bat || true
    sudo ln -sf "$(command -v batcat)" /usr/local/bin/bat 2>/dev/null || true
  fi
  if ! command -v bat &>/dev/null; then
    echo "=== Installing bat (manual) ==="
    install_binary_from_gh \
      "sharkdp/bat" \
      "https://github.com/sharkdp/bat/releases/download/VERSION/bat-VERSION-x86_64-unknown-linux-musl.tar.gz" \
      "bat" 1 || echo "⚠️ bat install failed"
  fi
fi

# ─── eza ──────────────────────────────────────────────────────────────────────

if ! command -v eza &>/dev/null; then
  if [ "$UBUNTU_VER" -ge 22 ]; then
    sudo apt install -y eza || true
  fi
  if ! command -v eza &>/dev/null; then
    echo "=== Installing eza (manual) ==="
    install_binary_from_gh \
      "eza-community/eza" \
      "https://github.com/eza-community/eza/releases/download/VERSION/eza_x86_64-unknown-linux-musl.tar.gz" \
      "eza" 0 || echo "⚠️ eza install failed"
  fi
fi

# ─── zoxide ───────────────────────────────────────────────────────────────────

if ! command -v zoxide &>/dev/null; then
  if [ "$UBUNTU_VER" -ge 22 ]; then
    sudo apt install -y zoxide || true
  fi
  if ! command -v zoxide &>/dev/null; then
    echo "=== Installing zoxide (manual) ==="
    curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash ||
      echo "⚠️ zoxide install failed"
  fi
fi

# ─── Starship ─────────────────────────────────────────────────────────────────

echo "=== Installing Starship ==="
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# ─── Oh-My-Zsh ────────────────────────────────────────────────────────────────

echo "=== Installing Oh-My-Zsh ==="
RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ||
  echo "⚠️ oh-my-zsh install failed"

ZSH_DIR="$HOME/.oh-my-zsh"

echo "=== Installing Zsh Plugins ==="
if [ ! -d "$ZSH_DIR/custom/plugins/zsh-vi-mode" ]; then
  git clone https://github.com/jeffreytse/zsh-vi-mode \
    "$ZSH_DIR/custom/plugins/zsh-vi-mode"
fi
if [ ! -d "$ZSH_DIR/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_DIR/custom/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_DIR/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_DIR/custom/plugins/zsh-syntax-highlighting"
fi
if [ ! -d "$ZSH_DIR/custom/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab \
    "$ZSH_DIR/custom/plugins/fzf-tab"
fi

# ─── Atuin ────────────────────────────────────────────────────────────────────

echo "=== Installing Atuin ==="
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
