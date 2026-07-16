# mini.bufremove

Nguồn: `mini-bufremove.txt`

Validated hiện tại:
- load trong config `nvim-mini` qua `require("mini.bufremove").setup()`
- current config không thấy keymap riêng cho module này
- chưa validate runtime thao tác xóa buffer hiện tại

## Mục tiêu
- Bỏ buffer mà giữ layout window ổn định.
- Phân biệt unshow / delete / wipeout rõ ràng.
- Dùng thay cho `:bdelete` / `:bwipeout` khi không muốn vỡ layout.

## Điểm nổi trội / given
- unshow, delete, wipeout buffer mà giữ window layout
- có fallback chọn buffer khác để hiện trong window
- hỗ trợ confirm khi buffer còn unsaved
- có `force` nếu muốn bỏ qua unsaved changes

## Test
- unshow:
  - `:lua MiniBufremove.unshow()` -> ẩn buffer hiện tại khỏi mọi window đang show nó
- delete:
  - `:lua MiniBufremove.delete()` -> `:bdelete` nhưng giữ layout
  - `:lua MiniBufremove.delete(0, true)` -> delete force
- wipeout:
  - `:lua MiniBufremove.wipeout()` -> `:bwipeout` nhưng giữ layout
- alternate / previous fallback:
  - mở 2-3 buffer rồi delete buffer hiện tại -> window chuyển sang alternate hoặc previous buffer thay vì đóng layout
