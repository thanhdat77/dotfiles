# mini.input

Nguồn: `mini-input.txt`

Validated hiện tại:
- chưa load trong `nvim-mini`
- chưa validate runtime hiện tại

## Mục tiêu
- Lấy input đồng bộ nhưng không block UI.
- Thay `vim.ui.input()` khi muốn view/key handling tốt hơn.
- Tùy view theo scope hoặc workflow.

## Điểm nổi trội / given
- input handler tùy biến cho key, highlight, completion, view
- có nhiều built-in view: floatwin, statusline/tabline/winbar, virtual line/text
- non-blocking nhưng vẫn trả kết quả đồng bộ
- dùng được ở mọi mode, không ép vào Insert mode
- có implementation cho `vim.ui.input()`
- state rất rõ: caret, completion items, highlight, prompt, status

## Test
- `MiniInput.get({ prompt = 'Name' })`: effect là mở prompt nhận chuỗi rồi trả về input
- dùng completion `cmdline`: effect là có input kiểu command line với completion/hightlight tùy handler
- custom key handler như `<C-a>` về đầu dòng: effect là đổi behavior nhập mà không đổi mode
- đổi view theo scope: effect là cùng input nhưng hiện ở float / tabline / winbar / virtual line
- `hide = true`: effect là input kiểu password, text không lộ ra view
- dùng qua `vim.ui.input()`: effect là plugin khác có thể tận dụng nếu setup module này