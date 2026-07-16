# mini.surround

Nguồn: `mini-surround.txt`

Validated hiện tại:
- được gọi `require("mini.surround").setup()` trong `nvim-mini`
- có mapping `sa` `sd` `sr` `sf` `sF` `sh`
- config hiện tại không override mapping mặc định

## Mục tiêu
- Thao tác add / delete / replace / find / highlight quanh surrounding.
- Dùng chung một bộ key cho bracket, quote, function call, tag, prompt.
- Tận dụng `next` / `last` search khi target không nằm ngay dưới cursor.

## Điểm nổi trội / given
- có 5 action nhất quán: add, delete, replace, find, highlight
- builtin input/output gồm bracket, quote alias, function call, tag, prompt, default same-char surround
- hỗ trợ count, dot-repeat
- có extended suffix để ép tìm `next` / `last`
- search dựa trên Lua pattern; tag và function call có thể false positive ở case khó

## Test
- add:
  - `saiw)` → thêm `()` quanh word
  - `saiw?` → surround tương tác bằng cặp trái/phải tự nhập
- delete / replace:
  - `sd)` → bỏ cặp `()` đang cover cursor
  - `sr)` rồi `t` → đổi từ paren sang tag
- function / tag:
  - `sdf` → bỏ function call outer, giữ args
  - `sff` → nhảy tới mép phải của function surround
- next / last:
  - `sdnf` → xóa function call kế tiếp
  - `srlf(` → replace function call phía trước bằng padded `(`
- highlight:
  - `sh}` → flash vùng surround hiện tại để xác nhận target
- input/output khác nhau rõ:
  - `)` input không pad whitespace như `(` output padded version
  - `q` là alias quote; `f` input tìm function call, output sẽ hỏi tên function mới
