# mini.basics

Nguồn: `mini-basics.txt`

Validated hiện tại:
- load trong config `nvim-mini` qua `require("mini.basics").setup(...)`
- config hiện tại có:
  - `options.basic = false`
  - `options.extra_ui = true`
  - `options.win_borders = "rounded"`
  - `mappings.basic = true`
  - `mappings.option_toggle_prefix = [[\]]`
  - `mappings.windows = true`
  - `mappings.move_with_alt = true`
  - `autocommands.basic = true`
  - `autocommands.relnum_in_visual_mode = true`
- headless check đã thấy mapping tồn tại cho `<C-s>` / `<C-h>` / `<M-h>` / `\w`

## Mục tiêu
- Lấy preset mapping/autocmd phổ biến thay vì tự dựng từ đầu.
- Chỉ bật phần tiện ích cần dùng.
- Dùng như lớp preset nền, không thay cấu trúc config khác.

## Điểm nổi trội / given
- preset cho options, mappings, autocommands
- chỉ đổi option/map nếu chưa tự set trước đó
- có nhóm toggle option theo prefix
- có preset window navigation và move bằng Alt
- có preset `extra_ui` và border đồng bộ

## Test
- mapping cơ bản:
  - `<C-s>` -> lưu và về Normal
  - `go` -> thêm dòng trống sau cursor
  - `gO` -> thêm dòng trống trước cursor
- toggle option:
  - `\w` -> bật/tắt `wrap`
  - `\s` -> bật/tắt `spell`
- window preset:
  - `<C-h>` / `<C-l>` -> đổi focus window
  - `<C-Up>` / `<C-Down>` -> resize window
- move_with_alt:
  - Insert mode `Alt-h` / `Alt-l` -> di chuyển cursor không thoát mode
- extra UI hiện tại:
  - `:set list?`
  - `:set winblend?`
  - `:set pumheight?`
- relnum_in_visual_mode:
  - vào Visual line/block -> `relativenumber` chỉ bật trong lúc chọn
