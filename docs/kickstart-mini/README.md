# Kickstart Mini / Neovim Usecases

Sổ tay nhỏ để tập dùng Neovim như newbie, lưu lại các workflow đã học.

## 0. Các config hiện có

```bash
nvim                          # Vim thường / LazyVim
NVIM_APPNAME=nvim-mini nvim    # Mini sandbox tự build
NVIM_APPNAME=nvim-minimax nvim # MiniMax config chính chủ nvim-mini
```

## 1. MiniMax

Mở MiniMax:

```bash
NVIM_APPNAME=nvim-minimax nvim
```

Mở file init của MiniMax:

```vim
<Space>ei
```

Usecase:
- dùng để học config mini.nvim sạch hơn
- đọc từng file config
- thử workflow mới trước khi bê qua vim thường

## 2. Mini Files

Mở file explorer:

```vim
<leader>e
```

Workflow:
- tạo file: thêm dòng tên file mới rồi `:w`
- tạo folder: thêm dòng có `/` cuối rồi `:w`
- rename: sửa tên dòng rồi `:w`
- move: đổi path rồi `:w`
- delete: xóa dòng rồi `:w`
- toggle dotfiles: `g.`

Ghi nhớ: mini.files giống kiểu chỉnh filesystem như chỉnh text.

## 3. Mini Pick

```vim
<leader><space>  # git files
<leader>ff       # find files
<leader>fg       # live grep
<leader>fr       # resume picker
<leader>,        # buffers
<leader>fh       # help
```

Usecase:
- tìm file nhanh
- grep text trong project
- quay lại picker trước đó bằng resume

## 4. Git trong vim thường

### Neogit

```vim
<leader>gg # mở Neogit
<leader>gc # commit
<leader>gb # branch
```

Neogit đang mở kiểu tab:

```vim
gt        # tab sau
gT        # tab trước
2gt       # nhảy tab số 2
:tabclose # đóng tab hiện tại
```

### Gitsigns

```vim
]c          # next git hunk
[c          # prev git hunk
<leader>hp # preview hunk
<leader>hs # stage hunk
<leader>hr # reset hunk
<leader>hS # stage buffer
<leader>hR # reset buffer
<leader>hb # blame line
<leader>hd # diff this
<leader>hq # hunks to quickfix
<leader>hl # hunks to loclist
```

Quickfix vs loclist:
- quickfix = global list cho toàn project
- loclist = local list cho window hiện tại

## 5. Diff style đã chỉnh

File chỉnh màu:

```txt
nvim/.config/nvim/lua/plugins/colorstheme.lua
```

Ý tưởng hiện tại:
- add: background xanh nhẹ
- delete: background đỏ nhẹ
- change line: background vàng nhẹ
- changed text: vàng đậm hơn
- filler `////` của vimdiff được ẩn bằng space

## 6. Mini.diff trong nvim-mini sandbox

Mở:

```bash
NVIM_APPNAME=nvim-mini nvim
```

Key dễ nhớ:

```vim
<leader>hp # preview/overlay hunk
<leader>hs # stage hunk
<leader>hr # reset hunk
<leader>hS # stage buffer
<leader>hR # reset buffer
<leader>hn # next hunk
<leader>hN # prev hunk
<leader>hq # hunks to quickfix
<leader>hl # hunks to loclist
<leader>ht # toggle mini.diff
```

Ghi nhớ:
- với git source: apply hunk = stage hunk
- mini.diff không hỗ trợ unstage hunk
- muốn unstage thì dùng Neogit hoặc git client khác

## 7. Daily newbie loop

Một vòng tập hằng ngày:

1. mở project

```bash
nvim
```

2. tìm file

```vim
<leader><space>
```

3. mở explorer nếu cần sửa cây file

```vim
<leader>e
```

4. sửa code

5. xem hunk

```vim
]c
<leader>hp
```

6. stage hunk/buffer

```vim
<leader>hs
<leader>hS
```

7. mở Neogit commit

```vim
<leader>gg
```

## 8. Chỗ để ghi thêm usecase

### Usecase mới

```txt
Ngày:
Vấn đề:
Phím dùng:
Kết quả:
Ghi chú:
```

### Snippet ghi nhanh

```txt
Usecase: 
Command/key: 
When to use: 
Gotcha: 
```
