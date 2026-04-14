# tmux-harpoon Guide

Bookmark windows and jump to them instantly — no prefix needed.

---

## Default Keys (no prefix required)

| Key | Action |
|-----|--------|
| `C-S-h` (Ctrl+Shift+H) | Add current window to harpoon |
| `C-h` (Ctrl+H) | Open harpoon list / jump to bookmark |

---

## How to Use

### 1. Bookmark a window

Go to the window you want to save → press `C-S-h`

### 2. Open the harpoon list

Press `C-h` → a list of bookmarked windows appears → pick one

### 3. Jump directly to a slot (custom keys)

Add to `.tmux.conf` to jump directly without opening the list:

```tmux
set -g @harpoon_key_append1 'M-1'   # Alt+1 → bookmark slot 1
set -g @harpoon_key_append2 'M-2'   # Alt+2 → bookmark slot 2
set -g @harpoon_key_append3 'M-3'   # Alt+3 → bookmark slot 3
set -g @harpoon_key_append4 'M-4'   # Alt+4 → bookmark slot 4
```

Then `C-Space r` to reload.

---

## Practice Flow

1. Open 3 windows in different directories
2. On each window press `C-S-h` to bookmark
3. Switch to any window → press `C-h` → pick a bookmark to jump back
4. (Optional) Set `M-1/2/3` keys to jump without the list

---

## Difference from sessionx / sesh

| Tool | Scope | Use for |
|------|-------|---------|
| harpoon | windows | bookmark specific windows you return to often |
| sessionx | sessions | manage all sessions |
| sesh | sessions + dirs | quick jump anywhere |
