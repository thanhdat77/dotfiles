#!/usr/bin/env bash

echo "🔹 Updating system..."
sudo apt update || echo "⚠️ apt update failed, skipping..."

echo "🔹 Installing base packages..."
sudo apt install -y \
  git curl unzip zsh build-essential \
  ripgrep fzf fd-find bat eza zoxide \
  just || echo "⚠️ some base packages failed"

# Fix Debian renames (fd, bat)
if ! command -v fd &>/dev/null; then
  sudo ln -sf $(which fdfind) /usr/local/bin/fd || echo "⚠️ fd symlink failed"
fi
if ! command -v bat &>/dev/null; then
  sudo ln -sf $(which batcat) /usr/local/bin/bat || echo "⚠️ bat symlink failed"
fi
echo "🔹 Installing lazygit..."
if ! command -v lazygit &>/dev/null; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" |
    grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
  curl -Lo lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin/ && rm lazygit.tar.gz lazygit
else
  echo "✅ lazygit already installed"
fi

echo "🔹 Installing navi..."
if ! command -v navi &>/dev/null; then
  curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install | bash
  mkdir -p ~/.local/bin
  mv navi ~/.local/bin/ 2>/dev/null || true
  export PATH="$HOME/.local/bin:$PATH"
else
  echo "✅ navi already installed"
fi

echo "🔹 Installing atuin (better history)..."
if ! command -v atuin &>/dev/null; then
  # Run as normal user, not sudo
  curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash
  echo 'export PATH="$HOME/.atuin/bin:$PATH"' >>~/.zshrc
  echo 'eval "$(atuin init zsh)"' >>~/.zshrc
else
  echo "✅ atuin already installed"
fi

echo "🔹 Installing starship..."
if ! command -v starship &>/dev/null; then
  if sudo apt install -y starship; then
    echo "✅ Installed starship via apt"
  else
    echo "⚠️ apt install starship failed, falling back to script installer..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y || echo "⚠️ starship script install failed"
  fi
fi

echo "🔹 Installing zellij..."
if ! command -v zellij &>/dev/null; then
  curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz |
    tar -xz || echo "⚠️ zellij download failed"
  sudo mv zellij /usr/local/bin/ 2>/dev/null || echo "⚠️ zellij move failed"
fi

echo "🔹 Installing atuin (better history)..."
if ! command -v atuin &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash || echo "⚠️ atuin install failed"
fi

echo "🔹 Installing asdf (version manager)..."
if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 || echo "⚠️ asdf clone failed"
fi

echo "🔹 Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || echo "⚠️ oh-my-zsh install failed"
fi

echo "🔹 Installing zsh plugins..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] &&
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions || echo "⚠️ autosuggestions skipped"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] &&
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || echo "⚠️ syntax-highlighting skipped"

echo "🔹 Configure Starship in zsh and bash..."
if ! grep -q 'starship init zsh' ~/.zshrc 2>/dev/null; then
  echo 'eval "$(starship init zsh)"' >>~/.zshrc
fi
if ! grep -q 'starship init bash' ~/.bashrc 2>/dev/null; then
  echo 'eval "$(starship init bash)"' >>~/.bashrc
fi

echo "🔹 Configure Atuin in zsh..."
if ! grep -q 'atuin init zsh' ~/.zshrc 2>/dev/null; then
  echo 'eval "$(atuin init zsh)"' >>~/.zshrc
fi

echo "🔹 Configure asdf in zsh..."
if ! grep -q 'asdf.sh' ~/.zshrc 2>/dev/null; then
  echo '. $HOME/.asdf/asdf.sh' >>~/.zshrc
  echo '. $HOME/.asdf/completions/asdf.bash' >>~/.zshrc
fi

echo "🔹 Setting zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh) || echo "⚠️ failed to set zsh as default shell"
fi

echo "✅ All tools installed! Restart terminal or run 'exec zsh'."
