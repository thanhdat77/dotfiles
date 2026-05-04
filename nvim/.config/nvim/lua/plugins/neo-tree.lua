return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
    sources = { "filesystem", "buffers", "git_status" },
    source_selector = {
      winbar = true,
      statusline = false,
      sources = {
        { source = "filesystem",  display_name = "  Files" },
        { source = "buffers",     display_name = "  Bufs" },
        { source = "git_status",  display_name = "  Git" },
      },
    },
    window = {
      width = 35,
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
