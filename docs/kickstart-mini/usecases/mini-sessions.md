# mini.sessions

Nguồn: `mini-sessions.txt`

Validated hiện tại:
- được gọi `require("mini.sessions").setup()` trong `nvim-mini`
- có keymap `<leader>fs` gọi `require("mini.sessions").select()`
- config hiện tại dùng setup mặc định; không thấy override `autoread` / `autowrite` / `directory` / `file`

## Mục tiêu
- Đọc / ghi / xóa session bằng một API Lua gọn.
- Dùng session global và local thay vì `:mksession` thủ công.
- Chọn session tương tác qua `vim.ui.select()`.

## Điểm nổi trội / given
- dựa trên `:mksession`, nên tôn trọng `sessionoptions`
- có 2 loại session: global trong directory cấu hình, local trong cwd
- không tự tạo session mới; ghi bằng `write()` khi cần
- có autoread default session, autowrite session đang active, restart preserving session
- có hook trước/sau cho read / write / delete

## Test
- select:
  - `<leader>fs` → mở picker/select UI cho action `read` mặc định
- write:
  - `:lua MiniSessions.write("work.vim")` → tạo global session readable file
  - `:lua MiniSessions.write("Session.vim")` → ghi local session ở cwd
- read:
  - `:lua MiniSessions.read("work.vim")` → wipe buffer hiện tại rồi source session target
- delete:
  - `:lua MiniSessions.delete("work.vim")` → xóa session đã detect
- latest/default:
  - `:lua print(MiniSessions.get_latest())` → lấy session mới nhất theo mtime
- restart:
  - `:lua MiniSessions.restart()` → restart Neovim giữ session, cần Neovim >= 0.12
