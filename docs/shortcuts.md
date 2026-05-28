# Shortcuts Cheat Sheet

## ZSH

| Key | Action |
|-----|--------|
| `Ctrl+R` | Atuin history search |
| `Ctrl+E` | Accept full autosuggestion |
| `Ctrl+N` | Accept 1 word từ suggestion |
| `Ctrl+P` | Up history |
| `Ctrl+F` | TV sesh picker (sesh-smart-connect) |
| `Ctrl+T` | FZF file finder |
| `Alt+C` | FZF cd vào dir |
| `wf` | Vi-mode escape (insert → normal) |
| `v` | (vi normal mode) edit cmd trong nvim |

---

## TMUX — Prefix: `C-Space`

| Key | Action |
|-----|--------|
| `prefix + r` | Reload tmux.conf |
| `prefix + \|` | Split ngang |
| `prefix + -` | Split dọc |
| `prefix + v` | Vào copy mode |
| `prefix + m` | Toggle zoom pane |
| `prefix + Space` | Switch to last session/client |
| `prefix + H/J/K/L` | Resize pane left/down/up/right |
| `prefix + f` | TV sesh picker (popup) |
| `prefix + F` | TV claude-sessions picker (popup) |
| `prefix + s` | Sessionx picker |
| `prefix + C-r` | Window 1 |
| `prefix + C-s` | Window 2 |
| `prefix + C-t` | Window 3 |
| `prefix + C-w` | Window 4 |
| `prefix + C-f` | Window 5 |
| `prefix + C-p` | Window 6 |
| `Ctrl+F` | TV sesh picker from any tmux pane |

### TV Sesh Picker

| Key | Action |
|-----|--------|
| `Enter` | Connect to selected session |
| `Ctrl+D` | Kill selected tmux session |

### TMUX Overrides

| Key | Default tmux | Current setup |
|-----|--------------|---------------|
| `Ctrl+B` | Prefix | Disabled; prefix is `Ctrl+Space` |
| `prefix + %` | Split horizontal | Replaced by `prefix + \|` |
| `prefix + "` | Split vertical | Replaced by `prefix + -` |
| `prefix + f` | Find window | TV sesh picker popup |
| `prefix + L` | Last session/client | Resize pane right |
| `prefix + Space` | Send prefix to pane | Switch to last session/client |
| `Ctrl+F` | Sent to app in pane | Captured by tmux for sesh picker |
| copy-mode `v` | Default behavior | Begin visual selection |
| copy-mode `Ctrl+Shift+C` | No default binding | Copy selection to `win32yank.exe` |

Default resize still available:

| Key | Action |
|-----|--------|
| `prefix + Ctrl+Arrow` | Resize pane by 1 cell |
| `prefix + Alt+Arrow` | Resize pane by 5 cells |

### Copy Mode

| Key | Action |
|-----|--------|
| `v` | Begin selection |
| `Ctrl+Shift+C` | Copy to clipboard via `win32yank.exe` |
