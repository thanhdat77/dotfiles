# dotfiles

Personal dotfiles for Linux/WSL2 (Debian/Ubuntu). Managed with GNU Stow.

## Install

```bash
bash install.sh
```

Installs: `zsh`, `tmux`, `ripgrep`, `fzf`, `fd`, `bat`, `eza`, `zoxide`, `starship`, `oh-my-zsh`, `atuin`

> Run as a regular user (not root) — the script uses `sudo` internally.

## Stow setup

Clone the repo to `~/dotfiles`, then stow the packages you want:

```bash
cd ~/dotfiles
stow -t ~ zsh tmux starship yazi scripts
```

| Package | Creates |
|---------|---------|
| `zsh` | `~/.zshrc` |
| `tmux` | `~/.tmux.conf` |
| `starship` | `~/.config/starship/starship.toml` |
| `yazi` | `~/.config/yazi/` |
| `scripts` | `~/custom_scripts/` |

> `nvim` config lives at `~/.config/nvim/` as a separate git repo — stow it separately or clone directly.

## Structure

```
dotfiles/
├── zsh/.zshrc
├── tmux/.tmux.conf
├── starship/.config/starship/starship.toml
├── yazi/.config/yazi/
├── nvim/.config/nvim/
├── scripts/custom_scripts/
│   ├── tmux-sessionizer
│   ├── fzf_listoldfiles.sh
│   ├── zoxide_openfiles_nvim.sh
│   ├── nvim-install
│   └── yazi-install
└── install.sh
```

## Key bindings

**Tmux** (prefix: `C-Space`)

| Key | Action |
|-----|--------|
| `prefix + \|` / `-` | Split horizontal / vertical |
| `prefix + f` | tmux-sessionizer (fuzzy session switcher) |
| `prefix + C-y` | yazi float |
| `prefix + C-g` | lazygit float |
| `prefix + C-d` | lazydocker float |
| `prefix + C-t` | terminal float |
| `prefix + C-m` | music float (rmpc) |

**Zsh**

| Key / Alias | Action |
|-------------|--------|
| `^E` | Accept autosuggestion |
| `^P` / `^N` | History up / down |
| `tns` | tmux-sessionizer |
| `nlof` | fzf browse nvim oldfiles |
| `nzo` | fzf open files via zoxide dirs |
| `ld` | lazydocker |

## Theme

Catppuccin Mocha throughout — tmux, starship, bat, nvim.
