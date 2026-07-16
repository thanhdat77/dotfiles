# mini.deps

Nguồn: `mini-deps.txt`

Validated hiện tại:
- chưa thấy load trong config `nvim-mini`
- chưa validate runtime hiện tại
- theo doc: trên Neovim >= 0.12 nên ưu tiên `vim.pack`; development của `mini.deps` đã frozen

## Mục tiêu
- Quản lý plugin đơn giản bằng Git và built-in packages.
- Dùng khi muốn model add/update/clean/snapshot kiểu tối giản.
- Hiểu `now()` / `later()` như cách tách startup 2 giai đoạn.

## Điểm nổi trội / given
- add plugin vào session, tải nếu chưa có
- update / clean / snapshot bằng Lua function và user command
- spec tối giản: source, checkout, monitor, depends, hooks
- có `now()` và `later()` cho startup an toàn hai giai đoạn
- không cố làm lazy loader phức tạp hoặc thay session hiện tại sau update

## Test
- add plugin:
  - `MiniDeps.add('nvim-lua/plenary.nvim')` -> bảo đảm plugin có trên disk và usable trong session
- update:
  - `:DepsUpdate` -> tải update, mở confirmation buffer
- clean:
  - bỏ `MiniDeps.add()` của plugin rồi chạy `:DepsClean`
- snapshot:
  - `:DepsSnapSave`
  - `:DepsSnapLoad`
- startup split:
  - `MiniDeps.now(function() ... end)` -> chạy ngay
  - `MiniDeps.later(function() ... end)` -> defer sang event loop sau
