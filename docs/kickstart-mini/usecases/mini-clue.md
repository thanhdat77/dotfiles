# mini.clue

Nguồn: `mini-clue.txt`

Validated hiện tại:
- module được gọi trong config `nvim-mini` qua `require("mini.clue").setup()`
- current config không cấu hình `triggers` hay `clues` riêng
- theo doc: mặc định không có trigger nào nếu không cấu hình
- chưa validate clue window runtime hiện tại

## Mục tiêu
- Hiện gợi ý phím kế tiếp cho prefix hoặc trigger quan trọng.
- Tách phần mapping khỏi phần clue.
- Dùng để đọc hệ keymap lớn mà không phụ thuộc `timeoutlen`.

## Điểm nổi trội / given
- key query riêng, không phụ thuộc `timeoutlen`
- hiện floating window với next-key clues sau delay
- hỗ trợ postkeys để tạo submode
- có generator clue cho `g`, `z`, window, completion, marks, registers, square brackets
- desc từ keymap hiện có được ưu tiên dùng lại

## Test
- trigger cơ bản theo doc starter example:
  - `<Leader>` -> hiện clue các mapping leader
  - `g` -> hiện nhánh `g...`
  - `[` / `]` -> hiện clue nhóm square brackets
- behavior trong clue window:
  - `<BS>` -> lùi một key trong query
  - `<CR>` -> execute query hiện tại
  - `<C-d>` / `<C-u>` -> scroll clue window nếu đang mở
- submode:
  - trigger + postkeys -> giữ flow trong cùng nhóm lệnh
- hiện tại với config này:
  - cần thêm `triggers = {...}` trước khi mong clue window hoạt động thực tế
