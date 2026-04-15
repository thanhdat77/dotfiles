# dotfiles

Personal dotfiles for Linux/WSL2 (Debian/Ubuntu). Managed with GNU Stow.

## Install

```bash
bash setup/install.sh
```

> Run as a regular user (not root) — the script uses `sudo` internally.

## Structure

```
dotfiles/
├── zsh/
├── tmux/
├── starship/
├── yazi/
├── nvim/
├── atuin/
├── scripts/custom_scripts/
└── setup/
```

## Guides

| Guide | Content |
|-------|---------|
| [GUIDE_sesh.md](guide/GUIDE_sesh.md) | Session switching with sesh + ts |
| [GUIDE_tmux-sessionx.md](guide/GUIDE_tmux-sessionx.md) | Session manager UI |
| [GUIDE_tmux-harpoon.md](guide/GUIDE_tmux-harpoon.md) | Window bookmarks |
| [GUIDE_nvim-scripts.md](guide/GUIDE_nvim-scripts.md) | nf / nr fuzzy file open |
