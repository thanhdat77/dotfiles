# Custom Scripts Guide

Scripts live in `~/custom_scripts/` (symlinked from `dotfiles/scripts/custom_scripts/`).

---

## tmux-sessionizer

**Alias:** `tns`
**Tmux binding:** `prefix + f`

Fuzzy-find a directory and open it as a named tmux session. If the session already exists, switch to it instead.

```bash
tns              # opens fzf with dirs from ~/dotfiles, ~/, ~/workspace (depth 2)
tns ~/projects/foo  # jump directly to that dir as a session
```

How it works:
1. `fd` lists directories, piped to `fzf` for selection
2. Creates a new tmux session named after the directory (dots replaced with underscores)
3. If a `.tmux-sessionizer` file exists in the selected dir (or `~/`), it gets sourced as a startup hook

---

## fzf_listoldfiles.sh

**Alias:** `nlof` (nvim list old files)

Browse recently opened nvim files with fzf preview, then open selected files in nvim.

```bash
nlof    # fzf over recent files, preview with bat, open selection in nvim
```

How it works:
1. Reads nvim's `oldfiles` list (`:h v:oldfiles`)
2. Filters out non-existent files
3. Shows fzf with `bat` preview (multi-select enabled)
4. `cd`s into the first file's directory and opens all selected files

---

## zoxide_openfiles_nvim.sh

**Alias:** `nzo` (nvim zoxide open)

Find files using fzf locally or search across all zoxide-tracked directories.

```bash
nzo           # fzf over files in current directory
nzo <pattern> # search for <pattern> across all zoxide-tracked dirs
```

How it works:
- **No argument:** `fd` lists files in `.`, fzf picks one, opens in nvim
- **With argument:** iterates all dirs from `zoxide query -l`, searches each with `fd` for the pattern, collects matches into fzf
- If only one match is found, opens it directly (no fzf prompt)
- Always `cd`s into the file's directory before opening

---

## nvim-install

Install or update Neovim from the latest GitHub release.

```bash
~/custom_scripts/nvim-install
```

Downloads `nvim-linux-x86_64.tar.gz`, extracts to `/opt/nvim-linux-x86_64/`. Requires `sudo`. Make sure `/opt/nvim-linux-x86_64/bin` is in your `PATH`.

---

## yazi-install

Install or update Yazi file manager from the latest GitHub release.

```bash
~/custom_scripts/yazi-install
```

Downloads the linux binary, installs `yazi` and `ya` to `/usr/local/bin/`, and adds zsh completions. Requires `sudo`.

---

## Quick Reference

| Alias  | Script                      | What it does                          |
|--------|-----------------------------|---------------------------------------|
| `tns`  | `tmux-sessionizer`          | Fuzzy-pick dir, open as tmux session  |
| `nlof` | `fzf_listoldfiles.sh`       | Browse recent nvim files with fzf     |
| `nzo`  | `zoxide_openfiles_nvim.sh`  | Find files via zoxide + fzf, open in nvim |
| —      | `nvim-install`              | Install/update Neovim                 |
| —      | `yazi-install`              | Install/update Yazi                   |
