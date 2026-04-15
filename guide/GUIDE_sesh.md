# sesh Guide

Smart tmux session switcher using fzf + zoxide.

---

## Commands

### `ts [pattern]` — terminal

| Usage | Result |
|-------|--------|
| `ts` | Full fzf picker |
| `ts work` | 1 zoxide match → connect directly |
| `ts work` | Multiple matches → fzf over those |
| `ts abc` | No match → fzf with query pre-filled |

### `sesh list` — list sessions (works outside tmux)

```bash
sesh list       # sessions + zoxide dirs
sesh list -t    # tmux sessions only
sesh list -z    # zoxide dirs only
tmux ls         # plain tmux sessions
```

---

## Keybinding (inside tmux)

| Key | Action |
|-----|--------|
| `C-Space f` | Open sesh popup with preview |

Type to fuzzy-search → `Enter` to switch or create session.
