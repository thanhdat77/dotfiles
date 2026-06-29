# Herdr

Cheat sheet cho config hiện tại của mình.

## Start

```bash
herdr
```

Reload config đang chạy:

```bash
herdr server reload-config
```

Config file:

```bash
~/.config/herdr/config.toml
```

## Cảm giác dùng

- `tmux`-style, nhưng mouse-native
- giữ session/pane chạy sau khi detach
- Herdr Picker Plus thay `sesh` cho workspace/server/agent navigation
- hợp cho agent, log, shell, repo workspaces, SSH server panes

## Phím chính

| Key | Action |
| --- | --- |
| `ctrl+space` | vào prefix mode |
| `prefix+?` | help |
| `prefix+d` | detach |
| `prefix+f` / `prefix+s` | workspace picker |
| `prefix+shift+s` | settings |
| `prefix+c` | new tab |
| `prefix+n` / `prefix+p` | next / previous tab |
| `ctrl+1..9` | switch tab trực tiếp |
| `prefix+g` | goto picker |
| `ctrl+t` / `prefix+t` | Herdr Picker Plus |
| `prefix+shift+f` | file viewer split |
| `prefix+shift+n` | new workspace |
| `ctrl+shift+1..9` | switch workspace trực tiếp |
| `prefix+v` | split vertical |
| `prefix+-` | split horizontal |
| `prefix+h/j/k/l` | focus pane |
| `prefix+shift+h/j/k/l` | swap pane |
| `prefix+x` | close pane |
| `prefix+m` | zoom pane |
| `prefix+r` | resize mode |
| `prefix+b` | toggle sidebar |
| `prefix+[` | copy mode |

## Workflow hay dùng

1. Mở Herdr bằng `herdr`
2. `ctrl+t` hoặc `prefix+t` để mở Herdr Picker Plus
3. Chọn workspace/project/dir/agent/server
4. `Ctrl-S` trong picker để lọc server, Enter sẽ tạo/focus workspace `server: NAME` và chạy `ssh NAME`
5. `prefix+shift+f` để mở file viewer read-only cạnh pane hiện tại
6. Split pane cho app + log + agent
7. Dùng `prefix+d` để detach khi xong
8. Vào lại bằng `herdr` hoặc chọn workspace từ picker

## Terminal helper

```bash
~/custom_scripts/herdr-sync-server s92
```

- sync local Herdr config lên server khi cần
- mặc định không xoá file remote; thêm `--delete` nếu muốn mirror

## Ghi chú

- Mouse đang bật.
- `ctrl+t` và `prefix+t` mở Herdr Picker Plus.
- `prefix+shift+f` mở `herdr-file-viewer`.
- `prefix+f` / `prefix+s` vẫn là workspace picker built-in của Herdr.
- Theme đang map theo palette tmux của mình.
- Herdr config này được stow từ repo dotfiles.
- Nếu sửa config bằng tay, nhớ reload `herdr server reload-config`.
