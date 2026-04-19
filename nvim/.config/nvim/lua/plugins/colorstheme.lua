return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "dawn",

        -- 🎨 THIS is where you add it
        on_highlights = function(hl, c)
          hl.Normal = { bg = "#ffffff"  }
          hl.NormalFloat = { bg = "#f2f2f2" }
          hl.SignColumn = { bg = "#f2f2f2" }
        end,
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
}