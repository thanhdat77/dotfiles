# mini.ai

Nguồn: `mini-ai.txt`

Validated hiện tại:
- được gọi `require("mini.ai").setup()` trong `nvim-mini`
- có mapping `a` `i` `an` `in` `al` `il` `g[` `g]`
- test builtin trên text kiểu Python đã ra region hợp lệ cho `i"` `a"` `i)` `af` `aa`

## Mục tiêu
- Dùng textobject builtin nhanh và nhất quán.
- Tận dụng `next` / `last` / `goto edge`.
- Chỉ custom khi builtin hoặc treesitter thật sự cần.

## Điểm nổi trội / given
- builtin có bracket, quote, function call, argument, tag, prompt
- hỗ trợ `v:count`, dot-repeat, consecutive selection
- có nhiều search method
- có `g[]` để nhảy tới mép textobject
- có `gen_spec` và treesitter cho custom
- builtin chủ yếu dựa trên Lua pattern; có thể false positive trong string/comment phức tạp

## Test
- quote:
  - `i"` vs `a"` → inside string vs gồm luôn quote
- bracket:
  - `i)` → lấy phần trong `()`; với close bracket thì inner edge whitespace được giữ khác open bracket
- function / argument:
  - `af` → lấy cả `call(...)`
  - `aa` → lấy đúng argument hiện tại, không phải cả call
- next / last:
  - `an)` / `al)` → lấy object kế tiếp / phía trước nếu cursor không đang nằm trong object
- goto edge:
  - `g[)` / `g])` → nhảy tới mép trái / phải của object hiện tại
- count:
  - `2a)` → mở rộng ra pair bao ngoài; khác với một lần `a)`
