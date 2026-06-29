# Fenix Dotfiles

Personal Linux/WSL2 development environment managed with **GNU Stow**.

Focused on a fast terminal workflow: Zsh, Herdr, tmux, Neovim, workspace switching, fuzzy search, and WSL clipboard support.

## Features

- **Zsh** with vi-mode, autosuggestions, syntax highlighting, fzf-tab, Atuin history
- **Herdr** with `Ctrl-T` / `prefix+t` Picker Plus for workspaces, servers, agents, projects, and dirs
- **tmux** with `C-Space` prefix, pane/window shortcuts, WSL clipboard copy
- **Neovim** LazyVim-based config
- **Television + sesh** kept for legacy/fallback project switching
- **Starship**, **Yazi**, **Lazygit**, custom scripts
- Fresh-machine install and update scripts

## Install

```bash
git clone git@github.com:<your-user>/<your-repo>.git ~/dotfiles
cd ~/dotfiles
bash setup/install.sh
```

Run as a normal user, not root. The setup scripts call `sudo` only where needed.
Existing non-symlink config paths are backed up to `~/.dotfiles-backup/<timestamp>/` before stow replaces them.

After install:

```bash
exec zsh
```

## Update / Repair

Re-check installed tools and reinstall missing ones:

```bash
bash setup/update.sh
```

Verbose mode:

```bash
VERBOSE=1 bash setup/install.sh
```

## Managed Packages

These folders are stowed into `$HOME`:

| Package | Target |
|---|---|
| `zsh/` | `~/.zshrc`, `~/.zprofile` |
| `herdr/` | `~/.config/herdr/config.toml` |
| `tmux/` | `~/.tmux.conf`, tmux theme/resurrect config |
| `nvim/` | `~/.config/nvim` |
| `starship/` | `~/.config/starship` |
| `yazi/` | `~/.config/yazi` |
| `atuin/` | `~/.config/atuin` |
| `sesh/` | `~/.config/sesh` |
| `television/` | `~/.config/television` |
| `lazygit/` | `~/.config/lazygit/config.yml` |
| `scripts/` | `~/custom_scripts` |

## Current Commands & Prefix

### Zsh

| Key / Command | Action |
|---|---|
| `Ctrl+R` | Atuin history search |
| `Ctrl+E` | Accept full autosuggestion |
| `Ctrl+N` | Accept one word from suggestion |
| `Ctrl+P` | Previous history |
| `Ctrl+F` | Television sesh picker |
| `Ctrl+T` | Herdr Picker Plus workdir/server/agent picker |
| `Alt+C` | FZF cd into directory |
| `wf` | vi-mode escape: insert → normal |
| `v` | edit current command in Neovim |

### tmux

Prefix:

```text
Ctrl+Space
```

| Key | Action |
|---|---|
| `prefix + r` | Reload tmux config |
| `prefix + \|` | Split pane horizontally |
| `prefix + -` | Split pane vertically |
| `prefix + v` | Copy mode |
| `prefix + m` | Toggle pane zoom |
| `prefix + Space` | Switch to last session/client |
| `prefix + H/J/K/L` | Resize pane left/down/up/right |
| `prefix + f` | Television sesh picker popup |
| `Ctrl+T` | Herdr Picker Plus from any tmux pane |
| `prefix + F` | Television Claude sessions picker popup |
| `prefix + s` | Sessionx picker |
| `prefix + C-r` | Select window 1 |
| `prefix + C-s` | Select window 2 |
| `prefix + C-t` | Select window 3 |
| `prefix + C-w` | Select window 4 |
| `prefix + C-f` | Select window 5 |
| `prefix + C-p` | Select window 6 |

### tmux Copy Mode

| Key | Action |
|---|---|
| `v` | Begin visual selection |
| `Ctrl+Shift+C` | Copy selection to clipboard via `win32yank.exe` |

## Useful Guides

| Guide | Content |
|---|---|
| [`docs/shortcuts.md`](docs/shortcuts.md) | Full shortcut cheat sheet |
| [`herdr/README.md`](herdr/README.md) | Herdr workflow and Picker Plus shortcuts |
| [`guide/GUIDE_sesh.md`](guide/GUIDE_sesh.md) | Legacy session switching with sesh |
| [`guide/GUIDE_tmux-sessionx.md`](guide/GUIDE_tmux-sessionx.md) | tmux session manager UI |
| [`guide/GUIDE_tmux-harpoon.md`](guide/GUIDE_tmux-harpoon.md) | tmux window bookmarks |
| [`guide/GUIDE_nvim-scripts.md`](guide/GUIDE_nvim-scripts.md) | `nf` / `nr` fuzzy file open |

## Repository Layout

```text
.
├── atuin/        # Atuin history config
├── herdr/        # Herdr config
├── lazygit/      # Lazygit config
├── nvim/         # Neovim config
├── scripts/      # Custom shell scripts
├── sesh/         # sesh config
├── setup/        # install/update scripts
├── starship/     # prompt config
├── television/   # Television picker config
├── tmux/         # tmux config
├── wezterm/      # WezTerm config
├── yazi/         # file manager config
└── zsh/          # shell config
```

## Notes

- Optimized for Ubuntu/Debian and WSL2.
- Clipboard integration uses `win32yank.exe` when running inside WSL.
- GNU Stow is the source of truth; edit files in this repo, then re-stow if needed.
