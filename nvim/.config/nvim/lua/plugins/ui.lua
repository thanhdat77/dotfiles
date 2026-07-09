return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
      indent = {
        enabled = true,
        char = "▏",
        -- only_current = true,
        -- only_scope = true, -- CHỈ hiện block bạn đang đứng (Sạch nhất)
      },
      scope = {
        enabled = true,
        char = "▏",
        underline = false,
        only_current = true,
        min_size = 15,
      },
      chunk = {
        enabled = false,
        char = {
          corner_top = "┌",
          corner_bottom = "└",
          horizontal = "─",
          vertical = "│",
        },
      },
      animate = { enabled = false },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          -- Palette màu của bạn
          local scope_color = "#C3BD9D" -- Màu tím/cam nhạt bạn chọn
          local hidden_color = "#E0E0E0" -- Màu gần tiệp với nền (Nord/Dark theme)

          vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = scope_color, bold = false })
          vim.api.nvim_set_hl(0, "SnacksIndent", { fg = hidden_color, blend = 100 })
          vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = scope_color })

          for i = 1, 20 do
            vim.api.nvim_set_hl(0, "SnacksIndent" .. i, { fg = hidden_color })
            vim.api.nvim_set_hl(0, "SnacksIndentScope" .. i, { fg = scope_color })
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>ui",
        function()
          Snacks.indent.toggle()
        end,
        desc = "Toggle Indent Lines",
      },
      {
        "<leader>us",
        function()
          Snacks.scope.toggle()
        end,
        desc = "Toggle Scope Lines",
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>y",
        "<cmd>Yazi<cr>",
        mode = { "n", "v" },
        desc = "Open Yazi (current file)",
      },
      {
        "<leader>Y",
        "<cmd>Yazi cwd<cr>",
        desc = "Open Yazi (cwd)",
      },
      {
        "<C-Up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume Yazi",
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}

-- return {
--
--   {
--
--     "folke/snacks.nvim",

--     opts = {
--
--       indent = { enabled = false }, -- Tắt hẳn module vẽ indent của Snacks
--
--       scope = { enabled = true }, -- Tắt luôn phần scope của Snacks
--
--     },
--
--   },
--
--   {
--
--     "lukas-reineke/indent-blankline.nvim",
--
--     opts = {
--
--       indent = {
--
--         char = "▏", -- Ký tự mảnh
--
--         highlight = "IblIndent",
--
--       },
--
--       scope = {
--
--         enabled = true,
--
--         char = "▏",
--
--         highlight = "IblScope",
--
--         show_start = false,
--
--         show_end = false,
--
--       },
--
--     },
--
--     config = function(_, opts)
--
--       vim.api.nvim_set_hl(0, "IblIndent", { fg = NONE })
--
--       vim.api.nvim_set_hl(0, "IblScope", { fg = "#A0AAF8" })
--
--
--       require("ibl").setup(opts)
--
--     end,
--
--   },
--
-- }
