# mini.misc

Nguồn: `mini-misc.txt`

Validated hiện tại:
- load trong `nvim-mini`
- gọi `require("mini.misc").setup()` không có config riêng
- chưa validate runtime hiện tại cho từng helper riêng lẻ

## Mục tiêu
- Gom các helper tiện dụng không thuộc một workflow đơn lẻ.
- Dùng khi cần debug, benchmark, auto-root, restore cursor, zoom, put/log.
- Tránh tự viết lại nhiều utility nhỏ trong config.

## Điểm nổi trội / given
- không bắt buộc setup, nhưng setup giúp tăng usability.
- có `put` / `put_text` để in object nhanh.
- có in-memory log để debug Lua flow.
- có benchmark + summary số liệu.
- có `safely()` cho lazy/fail-safe execution.
- có helper auto-root, restore cursor, term background sync, zoom.

## Test
- `:lua MiniMisc.put(vim.bo.filetype)`: in object ra command line.
- `:lua MiniMisc.put_text(vim.fn.getcwd())`: chèn output vào buffer hiện tại.
- `:lua MiniMisc.log_add('state', { cwd = vim.fn.getcwd() })` rồi `:lua MiniMisc.log_show()`: ghi và mở log scratch.
- `:lua MiniMisc.bench_time(function() return vim.fn.getcwd() end, 1000)`: benchmark một function nhỏ.
- `:lua MiniMisc.zoom()`: phóng buffer hiện tại vào floating window rồi toggle lại.
- `:lua MiniMisc.setup_restore_cursor()`: lần mở lại file sẽ về vị trí cursor cũ.
- `:lua MiniMisc.setup_auto_root()`: `cwd` tự đổi theo root tìm được của buffer.
