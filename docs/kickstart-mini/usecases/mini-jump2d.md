# mini.jump2d

Nguồn: `mini-jump2d.txt`

Validated hiện tại:
- load trong `nvim-mini`
- có custom mapping `s` ở `n` / `x` / `o`
- mapping `s` gọi `MiniJump2d.start(MiniJump2d.builtin_opts.single_character)`
- chưa thấy custom config khác cho labels / view / allowed_lines / allowed_windows

## Mục tiêu
- Jump nhanh trong vùng đang thấy bằng label filtering.
- Dùng `s` như entry point ngắn cho single-character jump.
- Giảm số lần search/motion liên tiếp khi target đang ở visible lines.

## Điểm nổi trội / given
- jump theo spot + label, không theo thứ tự ưu tiên gần/xa.
- lọc dần tới spot duy nhất bằng cách gõ label.
- có builtin spotter: line start, word start, single character, query.
- chạy được trong `x` / `o`.
- hỗ trợ nhiều window visible trong tab hiện tại.
- hỗ trợ multibyte characters.

## Test
- `s` rồi gõ `a`: hiện label trên các spot khớp ký tự `a`, gõ tiếp label để nhảy đúng spot.
- `s` trong `x` / `o`: chọn hoặc operator tới spot được gán label.
- `<CR>` trong lúc filtering: nhảy tới spot khả dụng đầu tiên.
- thử trên nhiều split visible: spot có thể xuất hiện ngoài current window theo default config.
- thử word/line spotter bằng lệnh Lua khi cần:
  - `:lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)`
  - `:lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)`
