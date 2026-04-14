# tmux Session Manager Guide

Prefix key: `C-Space` (Ctrl+Space)

---

## sessionx — `C-Space O`

Full session manager with fuzzy search.

### Open

```
C-Space  O
```

### Navigation

| Key | Action |
|-----|--------|
| `j` / `↓` | Move down |
| `k` / `↑` | Move up |
| Type anything | Fuzzy search by name |

### Actions inside popup

| Key | Action |
|-----|--------|
| `Enter` | Switch to session |
| `Ctrl-n` | Create new session |
| `Ctrl-r` | Rename session |
| `Ctrl-d` | Delete session |
| `Tab` | Multi-select |
| `Ctrl-x` | Kill all selected |
| `Esc` / `q` | Close popup |

---

## sesh — `C-Space f`

Quick jump to any session or directory (includes zoxide history).

```
C-Space  f
```

Type to fuzzy-search → `Enter` to switch or create.

---

## Practice Flow

1. Create sessions: `C-Space :new-session -s work` then `:new-session -s personal`
2. Open sessionx: `C-Space O`
3. Use `j/k` to navigate
4. Type `wo` to fuzzy-search "work"
5. Press `Enter` to switch
6. Try `Ctrl-r` to rename
7. Try `Ctrl-d` to delete

---

## Quick Reference

| Shortcut | Tool | Best for |
|----------|------|----------|
| `C-Space O` | sessionx | Manage sessions (rename, delete, create) |
| `C-Space f` | sesh | Jump to any session or directory |
| `C-Space r` | — | Reload tmux config |
| `C-Space \|` | — | Split pane horizontal |
| `C-Space -` | — | Split pane vertical |
| `C-Space m` | — | Maximize/restore pane |
