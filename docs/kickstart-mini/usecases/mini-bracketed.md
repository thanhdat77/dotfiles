# mini.bracketed

Nguồn: `mini-bracketed.txt`

Validated hiện tại:
- load trong config `nvim-mini`
- headless check đã thấy mapping lower/upper cho target chính, ví dụ:
  - `[b` `]b` `[B` `]B`
  - `[d` `]d` `[D` `]D`
  - `[q` `]q` `[Q` `]Q`
  - `[w` `]w` `[W` `]W`

## Mục tiêu
- Dùng một pattern `[` / `]` thống nhất cho motion theo target.
- Tận dụng count, first, last thay vì nhớ nhiều mapping rời.
- Dùng tốt với list/buffer/window/diagnostic/hunk-like navigation.

## Điểm nổi trội / given
- mỗi target có 4 hướng: backward / forward / first / last
- hỗ trợ count
- có wrap ở edge
- target đa dạng: buffer, comment, conflict, diagnostic, file, indent, jump, location, oldfile, quickfix, treesitter, undo, window, yank
- có thể đổi suffix hoặc disable từng target

## Test
- buffer:
  - `]b` -> buffer kế tiếp
  - `[B` -> buffer đầu
- diagnostic:
  - `]d` -> diagnostic kế tiếp
  - `]D` -> diagnostic cuối
- quickfix / location:
  - `]q` -> entry quickfix kế tiếp
  - `[L` -> entry loclist đầu
- window:
  - `]w` -> window kế tiếp trong tab
  - `[W` -> window đầu
- indent:
  - `]i` -> chỗ đổi indent kế tiếp
- count:
  - `3]d` -> nhảy 3 diagnostic
  - `2[b` -> lùi 2 buffer
