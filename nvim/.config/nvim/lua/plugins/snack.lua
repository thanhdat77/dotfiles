return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = false },
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
      win = {
        input = {
          keys = {
            ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<C-i>"] = { "toggle_ignored", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<C-h>"] = { "toggle_hidden", mode = { "n", "x" } },
            ["<C-i>"] = { "toggle_ignored", mode = { "n", "x" } },
          },
        },
      },
      sources = {
        notifications = {
          confirm = "copy_msg",
        },
      },
    },
  },
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    { "<leader>fe", false },
    { "<leader>fE", false },
  },
}
