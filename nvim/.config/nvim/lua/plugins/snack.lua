return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = { enabled = true },
    picker = {
      actions = {
        copy_msg = function(picker, item)
          local text = item.preview.text or item.item.msg or ""
          vim.fn.setreg("+", text)
          vim.notify("Yanked: " .. text:sub(1, 40))
          picker:close()
        end,
      },
      sources = {
        notifications = {
          confirm = "copy_msg",
        },
      },
    },
  },
  keys = {},
}
