# mini.jump

Nguồn: `mini-jump.txt`

Validated hiện tại:
- load trong `nvim-mini`
- đang dùng mapping mặc định của module: `f` `F` `t` `T` `;`
- các mapping trên có tồn tại ở `n` / `x` / `o`
- chưa thấy custom config riêng cho `delay` hoặc `silent`

## Mục tiêu
- Mở rộng `f/F/t/T` qua nhiều dòng.
- Lặp jump cùng target bằng `;`.
- Dùng như motion gốc của Vim nhưng ít bị giới hạn bởi line hiện tại.

## Điểm nổi trội / given
- `f/F/t/T` đi được nhiều dòng.
- gõ lại `f/F/t/T` để tiếp tục cùng target.
- có highlight target sau một khoảng delay.
- hỗ trợ `n` / `x` / `o` và dot-repeat kiểu operator-pending.
- theo `ignorecase` và `smartcase`.

## Test
- `f{char}` trên nhiều dòng: nhảy tới match kế tiếp, không dừng ở line hiện tại.
- `F{char}`: tìm ngược nhiều dòng.
- `t{char}` / `T{char}`: dừng trước/sau target như Vim, nhưng qua nhiều dòng.
- `;`: lặp lại jump gần nhất với cùng target.
- thử `ignorecase` + `smartcase`: target thường sẽ match không phân biệt hoa thường theo option hiện tại.
