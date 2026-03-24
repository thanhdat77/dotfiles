# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles for a Linux/WSL2 (Debian/Ubuntu) environment. Configs are organized by tool in subdirectories, each with a `.config/` folder that mirrors `~/.config/`.

## Installation

```bash
bash install.sh
```

The install script uses `sudo` — run as a regular user (not root). It:
1. Installs base packages via `apt`
2. Fixes Debian binary renames (`fdfind` → `fd`, `batcat` → `bat`)
3. Installs Starship, Oh-My-Zsh, zsh plugins, and Atuin

## Directory Structure & Symlinking

Each top-level directory is a tool configuration:

| Directory | Target |
|-----------|--------|
| `zsh/.zshrc` | `~/.zshrc` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `nvim/.config/nvim/` | `~/.config/nvim/` |
| `starship/.config/starship/` | `~/.config/starship/` |
| `yazi/.config/yazi/` | `~/.config/yazi/` |
| `scripts/custom_scripts/` | `~/custom_scripts/` |

Configs are symlinked (or copied) to their expected locations manually — there is no `stow` or automated symlink script currently.

## Key Design Decisions

**Shell (zsh):** Uses Oh-My-Zsh with plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `fzf-tab`. Vi mode is enabled (`set -o vi`) with `^E` to accept suggestions and `^P`/`^N` for history. Zoxide replaces `cd`. Atuin replaces shell history.

**Tmux:** Prefix is `C-Space`. TPM manages plugins. Key bindings:
- `prefix + |` / `prefix + -` — horizontal/vertical split
- `prefix + f` — tmux-sessionizer (fuzzy session switcher)
- `prefix + C-y` — yazi float, `prefix + C-g` — lazygit float, `prefix + C-t` — terminal float
- `prefix + d` — config quick-edit menu

Theme is Catppuccin Mocha throughout (tmux, bat, nvim).

**Scripts (`scripts/custom_scripts/`):** Contains `tmux-sessionizer` (bound to `tns` alias and tmux `prefix + f`) and `fzf_listoldfiles.sh` / `zoxide_openfiles_nvim.sh`.

**Nvim:** Installed as AppImage extracted to `/opt/nvim-linux-x86_64/bin/nvim`. Config lives in `nvim/.config/nvim/`.

**Lazygit:** Binary is checked in as `lazygit` and `lazygit.tar.gz` in the repo root. Config in `lazygit/.config/lazygit/` (if present).
