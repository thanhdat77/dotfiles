# mini.cmdline

Nguồn: `mini-cmdline.txt`

Validated hiện tại:
- chưa thấy load trong config `nvim-mini`
- chưa validate runtime hiện tại
- theo doc: cần Neovim >= 0.11, khuyến nghị >= 0.12

## Mục tiêu
- Tăng tốc flow command line mà không đổi UI tổng thể.
- Tận dụng autocomplete / autocorrect / autopeek khi gõ `:`.
- Giảm lỗi gõ lệnh và preview range sớm.

## Điểm nổi trội / given
- autocomplete có delay tùy chỉnh
- autocorrect word khi gõ, chủ yếu cho command/option từ tập cố định
- autopeek range bằng floating window
- tự set `wildmode` và `wildoptions` phù hợp nếu chưa set trước
- không thay UI command line, chỉ cải thiện workflow

## Test
- autocomplete:
  - `:e rea<Tab>` -> wildmenu gợi ý file
  - gõ `:set nu` -> completion hiện khi predicate cho phép
- autocorrect:
  - gõ sai lệnh gần đúng như `:setlca` -> tự sửa nếu nằm trong nhóm candidate phù hợp
- autopeek:
  - `:10,20d` -> nổi peek window cho range 10-20
  - `:%s/foo/bar/` -> range `%` được parse và peek nếu predicate cho phép
- config knobs đáng test:
  - `autocomplete.delay`
  - `autocorrect.enable`
  - `autopeek.n_context`
