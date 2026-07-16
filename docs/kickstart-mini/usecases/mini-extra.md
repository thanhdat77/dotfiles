# mini.extra

Nguồn: `mini-extra.txt`

Validated hiện tại:
- chưa load trong `nvim-mini`
- chưa validate runtime hiện tại

## Mục tiêu
- Bổ sung pickers cho `mini.pick`.
- Bổ sung textobject spec cho `mini.ai`.
- Bổ sung highlighter helper cho `mini.hipatterns`.

## Điểm nổi trội / given
- có thêm nhiều picker: diagnostic, explorer, git, history, lsp, treesitter, ...
- có `gen_ai_spec` cho textobject thực dụng như buffer / diagnostic / indent / line / number
- có `gen_highlighter` cho `mini.hipatterns`
- chỉ phụ thuộc module mini nào thực sự cần cho từng tính năng

## Test
- `MiniExtra.pickers.diagnostic()`: effect là mở picker chẩn đoán theo `mini.pick`
- `MiniExtra.pickers.explorer()`: effect là duyệt file qua picker thay vì column explorer
- `MiniExtra.pickers.git_hunks()` / git pickers: effect là pick branch / commit / file / hunk
- `MiniExtra.gen_ai_spec.buffer()`: effect là có textobject chọn toàn buffer
- `MiniExtra.gen_ai_spec.indent()`: effect là có textobject theo indent scope
- `MiniExtra.gen_ai_spec.number()`: effect là có textobject bắt số, kể cả `-` và decimal
- `MiniExtra.gen_highlighter.words(...)`: effect là tạo highlighter cho word list nhanh, không tự viết pattern tay