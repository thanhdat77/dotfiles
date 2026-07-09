return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.terminal("lazygit", {
            cwd = LazyVim.root.git(),
            win = {
              title = " Lazygit ",
            },
          })
        end,
        desc = "Lazygit",
      },
    },
  },
}
