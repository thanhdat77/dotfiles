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
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "github_light"

      vim.opt.fillchars:append({ diff = " " })

      local set_user_highlights = function()
        -- Git diff: used by vimdiff / Gitsigns diffthis (`<leader>hd`).
        -- Add and changed lines use green. Changed text uses darker green.
        vim.api.nvim_set_hl(0, "DiffAdd", { fg = "NONE", bg = "#c9e8d2" })
        vim.api.nvim_set_hl(0, "DiffChange", { fg = "NONE", bg = "#c9e8d2" })
        vim.api.nvim_set_hl(0, "DiffDelete", { fg = "NONE", bg = "#efc7c7" })
        vim.api.nvim_set_hl(0, "DiffText", { fg = "#0f5132", bg = "#8fd19e", bold = false })

        -- Pastel selection/search/yank palette.
        vim.api.nvim_set_hl(0, "Visual", { fg = "NONE", bg = "#eadcff" })
        vim.api.nvim_set_hl(0, "Search", { fg = "#0f3a5f", bg = "#cfe8ff" })
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "#0f3a5f", bg = "#b9d8ff" })
        vim.api.nvim_set_hl(0, "CurSearch", { fg = "#0f3a5f", bg = "#b9d8ff" })
        vim.api.nvim_set_hl(0, "YankHighlight", { fg = "#1b5e20", bg = "#d8f3dc" })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("UserPastelHighlights", { clear = true }),
        callback = set_user_highlights,
      })
      vim.schedule(set_user_highlights)
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
