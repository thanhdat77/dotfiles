# mini.visits

Nguồn: `mini-visits.txt`

Validated hiện tại:
- được gọi `require("mini.visits").setup()` trong `nvim-mini`
- chưa thấy keymap riêng cho visits trong config hiện tại
- chưa validate runtime tracking/labels hiện tại

## Mục tiêu
- Track file và directory visit theo project directory.
- Tái dùng visit data để list / select / iterate path.
- Gắn label bền vững cho path cần quay lại.

## Điểm nổi trội / given
- lưu visit index bền vững, dạng readable/editable
- track theo `cwd` và path tuyệt đối
- mặc định có normalize index trước khi ghi
- có label cho path
- có list/select/iterate path với filter và sort custom; default sort là robust frecency
- nếu rename/move bằng `mini.files`, index được autoupdate

## Test
- tracking:
  - mở vài file rồi đứng đủ lâu qua `track.delay` → path/cwd được register visit
- list/select:
  - `:lua print(vim.inspect(MiniVisits.list_paths()))` → xem path đã track
  - `:lua MiniVisits.select_path()` → chọn path qua `vim.ui.select()`
- iterate:
  - `:lua MiniVisits.iterate_paths("forward")` → đi path tiếp theo theo sort hiện tại
  - `:lua MiniVisits.iterate_paths("first")` → nhảy tới path đầu
- label:
  - `:lua MiniVisits.add_label('core')` → gắn label cho path hiện tại
  - `:lua print(vim.inspect(MiniVisits.list_labels()))` → xem label đã có
- index:
  - `:lua MiniVisits.write_index()` → flush index hiện tại ra disk
  - `:lua MiniVisits.rename_in_index(old_path, new_path)` → sửa index sau rename/move thủ công
