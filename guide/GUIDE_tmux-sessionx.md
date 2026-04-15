# tmux-sessionx Guide

Prefix key: `C-Space` (Ctrl+Space)

## Open

```
C-Space  O
```

---

## Inside the popup

### Navigate

| Key | Action |
|-----|--------|
| Type | Fuzzy search |
| `Ctrl+p` / `Ctrl+n` | Select up / down |

### Actions

| Key | Action |
|-----|--------|
| `Enter` | Switch to session |
| `Ctrl+r` | Rename selected session |
| `Ctrl+e` | Expand PWD — create session from local dirs |
| `Ctrl+w` | Window mode — list all windows with preview |
| `Ctrl+t` | Tree mode — sessions + windows tree |
| `Ctrl+b` | Back to session list |
| `Ctrl+x` | Open `~/.config` (or custom path) |
| `Ctrl+/` | tmuxinator sessions |
| `Ctrl+g` | fzf-marks |
| `Alt+Backspace` | Kill selected session |
| `Esc` | Close popup |

### Preview

| Key | Action |
|-----|--------|
| `Ctrl+u` | Scroll preview up |
| `Ctrl+d` | Scroll preview down |

---

## Practice Flow

1. `C-Space O` — open sessionx
2. Type to search, `Enter` to switch
3. `Ctrl+r` — rename a session
4. `Ctrl+w` — see all windows across sessions
5. `Alt+Backspace` — kill a session you don't need
