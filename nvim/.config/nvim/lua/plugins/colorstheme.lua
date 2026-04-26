return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_light",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "auto"
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "thin",
        always_show_bufferline = true,
      },
    },
  },
}
