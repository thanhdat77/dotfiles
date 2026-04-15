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

### Session actions

| Key | Action |
|-----|--------|
| `Enter` | Switch to session |
| `Ctrl+r` | Rename selected session |
| `Ctrl+e` | New window in selected session |
| `Ctrl+f` | New session from zoxide dir |
| `Alt+Backspace` | Kill selected session |
| `Esc` | Close popup |

### View modes

| Key | Action |
|-----|--------|
| `Ctrl+w` | Window mode — show windows instead of sessions |
| `Ctrl+t` | Tree mode — show session tree |
| `Ctrl+b` | Back to session list |

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
