# mini.files

Nguồn: `mini-files.txt`

Validated hiện tại:
- load trong `nvim-mini`
- config đang bật `use_as_default_explorer = true`
- config đang dùng `permanent_delete = false`
- config đang bật preview window
- config đang dùng `width_focus = 44`, `width_nofocus = 18`, `width_preview = 80`
- có keymap mở: `<leader>e`
- config có keymap picker quanh file explorer: `j` `k` `l` `L` `h` `H` `m` `'` `<BS>` `@` `g?` `=` `<` `>` theo mặc định module
- config có autocmd `MiniFilesBufferCreate` để thêm buffer-local `g.` toggle dotfiles

## Mục tiêu
- Duyệt cây file theo Miller columns.
- Mở file/dir nhanh mà vẫn giữ context của branch hiện tại.
- Tạo/xóa/rename/move trực tiếp bằng edit text.
- Dùng bookmark và synchronize cho batch đổi nhỏ.

## Điểm nổi trội / given
- column view cho nested directories, không phải tree một cột
- preview file/dir dưới cursor
- thao tác filesystem bằng cách sửa buffer text; create/delete/rename có LSP awareness
- dùng được như default explorer thay `netrw`
- có bookmark, trim branch, reveal cwd, synchronize
- theo doc: chỉ local filesystem; không phải thay thế file manager hệ thống

## Test
- `<leader>e`: mở explorer tại file hiện tại; effect là thấy branch thư mục theo cột
- `l` / `h`: đi vào / ra thư mục; effect là đổi focus giữa parent-child columns
- `L`: mở file rồi đóng explorer; `H`: go out rồi trim phải
- `@`: reveal cwd; effect là kéo branch hiện tại về chứa working directory nếu cùng ancestry
- `m{char}` rồi `'{char}`: set/jump bookmark thư mục
- thêm dòng `name.py` rồi `=`: effect là tạo file mới
- thêm dòng `pkg/` rồi `=`: effect là tạo thư mục mới
- sửa `old.py` thành `new.py` rồi `=`: effect là rename
- sửa `utils.py` thành `pkg/utils.py` rồi `=`: effect là move
- xóa whole line của entry rồi `=`: effect là delete; vì `permanent_delete = false` nên không xóa vĩnh viễn
- `g.`: toggle dotfiles bằng filter custom của config
- `<` / `>`: trim trái / phải branch đang mở để giảm cột hiển thị