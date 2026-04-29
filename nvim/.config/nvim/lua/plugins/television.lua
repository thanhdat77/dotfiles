return {
  {
    "alexpasmantier/tv.nvim",
    keys = {
      { "<leader>tv", "<cmd>Television<cr>", desc = "Television" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {},
    keys = {
      {
        "<leader>tV",
        function()
          Snacks.terminal("tv", { float = true })
        end,
        desc = "Television (float terminal)",
      },
    },
  },
}
