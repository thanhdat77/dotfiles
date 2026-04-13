#!/usr/bin/env bash
# cargo_install.sh — Install Rust toolchain + cargo packages

set -euo pipefail

VERBOSE="${VERBOSE:-0}"

say()  { printf '\n\033[1;32m==\033[0m %s\n' "$*"; }
info() { printf '   %s\n' "$*"; }
log()  { [ "$VERBOSE" = "1" ] && printf '   %s\n' "$*" || true; }
have() { command -v "$1" >/dev/null 2>&1; }

# rustup
say "rustup"
if ! have rustup; then
  info "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

if ! have cargo; then
  say "ERROR: cargo not found. Run: source ~/.cargo/env then re-run."
  exit 1
fi

rustup toolchain install stable >/dev/null 2>&1 || true
rustup default stable             >/dev/null 2>&1 || true

# cargo packages
say "cargo packages"

cargo_install() {
  log "cargo install $1"
  cargo install "$1" || true
}

cargo_install ripgrep       # rg
cargo_install fd-find       # fd
cargo_install bat           # bat
cargo_install eza           # eza
cargo_install broot         # br
cargo_install atuin         # atuin
cargo_install yazi-fm       # yazi
cargo_install yazi-cli      # ya

say "cargo done"
