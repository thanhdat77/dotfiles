# mini.pick

Nguồn: `mini-pick.txt`

Validated hiện tại:
- load trong `nvim-mini`
- có keymap hiện tại:
  - `<leader><space>` -> `builtin.files({ tool = "git" })`
  - `<leader>ff` -> `builtin.files()`
  - `<leader>fg` -> `builtin.grep_live()`
  - `<leader>,` -> `builtin.buffers()`
  - `<leader>fr` -> `builtin.resume()`
  - `<leader>fs` -> `mini.sessions.select()`
- config hiện tại đổi mapping trong picker:
  - `<C-j>` / `<C-k>` di chuyển
  - `<CR>` chọn
  - `<C-s>` split, `<C-v>` vsplit, `<C-t>` tab
  - `<Tab>` preview, `<S-Tab>` info, `<Esc>` stop
- window picker đang là float centered, border `rounded`, `prompt_prefix = "   "`

## Mục tiêu
- Dùng một picker chung cho file, grep, buffer, resume.
- Tận dụng query + preview + refine thay vì mở nhiều UI khác nhau.
- Giữ workflow nhẹ: file -> grep -> resume -> split/tab.

## Điểm nổi trội / given
- một cửa sổ cho main / preview / info.
- match mặc định là fuzzy, có exact/start/end modes.
- builtin có files, grep, buffers, help, CLI output, resume.
- có mark nhiều item rồi chọn cùng lúc.
- hỗ trợ `vim.ui.select()`.
- có cache match để phản hồi nhanh hơn.

## Test
- `<leader><space>`: chỉ pick Git files.
- `<leader>ff`: pick files thường.
- `<leader>fg`: live grep, query đổi thì match cập nhật live.
- `<leader>,`: pick buffer đang mở.
- `<leader>fr`: resume picker trước đó.
- `<C-j>` / `<C-k>`: đổi item hiện tại.
- `<Tab>` / `<S-Tab>`: bật preview hoặc info ngay trong cùng UI.
- `<C-s>` / `<C-v>` / `<C-t>`: mở item vào split, vsplit, tab.
- query `'abc'`: exact match; `^abc`: match đầu chuỗi; `abc$`: match cuối chuỗi; `*abc`: ép fuzzy.
- `<C-x>` / `<C-a>` rồi `<M-CR>`: mark current/all và chọn nhiều item cùng lúc.
