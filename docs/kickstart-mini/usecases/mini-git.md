# mini.git

Nguồn: `mini-git.txt`

Validated hiện tại:
- load trong `nvim-mini`
- chưa validate runtime hiện tại cho `:Git`; không claim `:Git` đã hoạt động
- chưa validate buffer summary trên file Git thật trong runtime hiện tại

## Mục tiêu
- Lấy Git data theo buffer/repo ngay trong Neovim.
- Đào history theo line/range/commit tại cursor.
- Dùng `:Git` như entry point Git CLI khi runtime hiện tại expose đúng.

## Điểm nổi trội / given
- track Git data tự động: root, status, HEAD, summary
- expose buffer-local data để dùng trong statusline
- có `:Git` để chạy `git` ở repo root của file hiện tại
- có `show_range_history()`, `show_diff_source()`, `show_at_cursor()`
- theo doc: không nhằm thay Git client đầy đủ; hợp với inspect theo context hiện tại của Neovim

## Test
- mở file thật đang nằm trong Git repo: effect là buffer có thể có `vim.b.minigit_summary` / `vim.b.minigit_summary_string`
- `:lua print(vim.inspect(vim.b.minigit_summary))`: effect là xem root / head / status summary nếu module đã track buffer đó
- `:lua MiniGit.show_at_cursor()`: trên line thường của file committed, effect là mở range history của line/range hiện tại
- đứng trên commit hash trong log output rồi `:lua MiniGit.show_at_cursor()`: effect là mở full commit tương ứng
- đứng trong unified diff rồi `:lua MiniGit.show_at_cursor()`: effect là mở file state trước/sau commit theo context cursor
- nếu runtime hiện tại có `:Git`, test `:Git status` / `:Git log --oneline` / `:vert Git blame -- %`: effect là mở output Git gắn với repo root hiện tại
- nếu runtime hiện tại có `:Git`, test `:Git log -<Tab>` và `:Git <Tab>`: effect là xem completion theo subcommand / option / target