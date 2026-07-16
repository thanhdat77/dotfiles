# mini.diff

Nguồn: `mini-diff.txt`

Validated hiện tại:
- load trong `nvim-mini`
- config đang dùng `view.style = "number"`
- config đang dùng `signs = { add = "▒", change = "▒", delete = "▒" }`
- config đang dùng source theo thứ tự: `git()` rồi `save()`
- config đang bật `algorithm = "histogram"`, `indent_heuristic = true`, `linematch = 60`, `wrap_goto = true`
- có custom highlight cho `MiniDiffSign*` và `MiniDiffOver*`
- có custom `MiniDiffUpdated` để format `vim.b.minidiff_summary_string`
- có keymap riêng: `<leader>hp` `<leader>hs` `<leader>hr` `<leader>hS` `<leader>hR` `<leader>hn` `<leader>hN` `<leader>ht` `<leader>hq` `<leader>hl`

## Mục tiêu
- Theo dõi hunk theo buffer khi đang sửa.
- Apply/reset hunk nhanh.
- Xem chi tiết diff bằng overlay.
- Xuất hunk ra quickfix/loclist khi cần rà nhiều chỗ.

## Điểm nổi trội / given
- diff theo hunk giữa buffer hiện tại và reference text
- có overlay để thấy add/delete/change chi tiết ngay trong text area
- source linh hoạt; mặc định hợp với Git nhưng không khóa vào Git
- có apply/reset theo region, textobject hunk, và goto first/prev/next/last hunk
- có buffer-local summary để đưa vào statusline
- theo doc: không thay Git client; `git` source không hỗ trợ unstage hunk

## Test
- sửa vài dòng rồi nhìn sign/number: thấy `add` / `change` / `delete`
- `]h` `[h` `[H` `]H`: nhảy next / prev / first / last hunk
- `ghgh` / `gHgh`: apply hoặc reset hunk dưới cursor
- `gh_` / `gH_`: apply/reset riêng line hiện tại
- visual chọn vùng rồi `gh` / `gH`: apply/reset cả vùng
- `dgh`: dùng hunk textobject làm target; effect là xóa đúng range hunk
- `<leader>hp`: bật overlay; effect là thấy deleted lines, changed parts, context ngay trong buffer
- `<leader>hs` / `<leader>hr`: wrapper dễ nhớ cho apply/reset hunk hiện tại
- `<leader>hS` / `<leader>hR`: apply/reset toàn buffer
- `<leader>hq` / `<leader>hl`: export hunk ra quickfix / loclist để duyệt theo list
- ngoài Git repo: `save()` làm reference theo lần `:w` gần nhất; effect là thấy diff kể từ save gần nhất