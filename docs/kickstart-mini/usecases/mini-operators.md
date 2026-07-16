# mini.operators

Nguồn: `mini-operators.txt`

Validated hiện tại:
- được gọi `require("mini.operators").setup()` trong `nvim-mini`
- có mapping mặc định `g=` `gx` `gm` `gr` `gs`
- config hiện tại không override prefix nào

## Mục tiêu
- Dùng operator thay cho command rời khi sửa text theo region.
- Tận dụng dot-repeat và count.
- Giữ một bộ prefix nhất quán cho replace / exchange / multiply / sort / evaluate.

## Điểm nổi trội / given
- có 5 operator: evaluate, exchange, multiply, replace, sort
- cùng một pattern dùng cho textobject, line, visual selection
- hỗ trợ count và dot-repeat
- mapping linewise theo dạng doubled như `grr`
- `exchange` và `replace` có option reindent linewise

## Test
- replace:
  - `griw` → thay object bằng register hiện tại
  - `grr` → thay cả dòng hiện tại
- exchange:
  - `gxiw` rồi `gxiw` ở vùng khác → đổi chỗ 2 vùng, kể cả khác buffer theo doc
- multiply:
  - `gmiw` → duplicate object
  - `gmm` → duplicate cả dòng
- sort:
  - `gsip` hoặc visual rồi `gs` → sort region; charwise mặc định tách được comma / semicolon / whitespace
- evaluate:
  - `g==` hoặc visual rồi `g=` → evaluate text và thay bằng output
- repeat:
  - làm một lần rồi `.` → lặp lại cùng operator trên target mới
