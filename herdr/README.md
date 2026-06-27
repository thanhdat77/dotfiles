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
- hợp cho agent, log, shell, repo workspaces

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
| `prefix+t` | dir picker → new workspace |
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
2. `prefix+f` để mở picker kiểu sesh
3. `prefix+t` để chọn dir rồi mở workspace mới
4. Chọn / tạo workspace
5. Split pane cho app + log + agent
6. Dùng `prefix+d` để detach khi xong
7. Vào lại bằng `herdr` hoặc chọn workspace từ picker

## Ghi chú

- Mouse đang bật.
- `prefix+f` là đường vào kiểu sesh picker, `prefix+s` giữ làm alias.
- `prefix+t` mở dir picker bằng zoxide/fzf rồi tạo workspace mới.
- Theme đang map theo palette tmux của mình.
- Herdr config này được stow từ repo dotfiles.
- Nếu sửa config bằng tay, nhớ reload `herdr server reload-config`.
