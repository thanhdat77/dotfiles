local features = require("config.features")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = not features.mini_ecosystem,
  },
  {
    "nvim-mini/mini.nvim",
    version = false,
    enabled = features.mini_ecosystem,
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()

      require("mini.files").setup({
        mappings = {
          close = "q",
          go_in = "l",
          go_in_plus = "L",
          go_out = "h",
          go_out_plus = "H",
          mark_goto = "'",
          mark_set = "m",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },
        options = {
          use_as_default_explorer = true,
          permanent_delete = false,
        },
        windows = {
          preview = true,
          width_focus = 44,
          width_nofocus = 18,
          width_preview = 80,
        },
      })

      require("mini.pick").setup({
        mappings = {
          choose = "<CR>",
          choose_in_split = "<C-s>",
          choose_in_vsplit = "<C-v>",
          choose_in_tabpage = "<C-t>",
          move_down = "<C-j>",
          move_up = "<C-k>",
          toggle_preview = "<Tab>",
          toggle_info = "<S-Tab>",
          stop = "<Esc>",
        },
        window = {
          config = function()
            local height = math.floor(vim.o.lines * 0.72)
            local width = math.floor(vim.o.columns * 0.72)
            return {
              anchor = "NW",
              height = height,
              width = width,
              row = math.floor((vim.o.lines - height) / 2),
              col = math.floor((vim.o.columns - width) / 2),
              border = "rounded",
            }
          end,
          prompt_prefix = "   ",
        },
      })

      local minidiff = require("mini.diff")
      minidiff.setup({
        view = {
          style = "number",
          signs = { add = "▒", change = "▒", delete = "▒" },
        },
        source = {
          minidiff.gen_source.git(),
          minidiff.gen_source.save(),
        },
        options = {
          algorithm = "histogram",
          indent_heuristic = true,
          linematch = 60,
          wrap_goto = true,
        },
      })

      local set_minidiff_highlights = function()
        vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = "#2e7d32" })
        vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "#2e7d32" })
        vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "#b42318" })
        vim.api.nvim_set_hl(0, "MiniDiffOverAdd", { fg = "NONE", bg = "#c9e8d2" })
        vim.api.nvim_set_hl(0, "MiniDiffOverChange", { fg = "#0f5132", bg = "#d9f0df" })
        vim.api.nvim_set_hl(0, "MiniDiffOverChangeBuf", { fg = "#0f5132", bg = "#8fd19e" })
        vim.api.nvim_set_hl(0, "MiniDiffOverContext", { fg = "#667085" })
        vim.api.nvim_set_hl(0, "MiniDiffOverContextBuf", { fg = "#667085" })
        vim.api.nvim_set_hl(0, "MiniDiffOverDelete", { fg = "NONE", bg = "#efc7c7" })
      end
      set_minidiff_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("UserMiniDiffHighlights", { clear = true }),
        callback = set_minidiff_highlights,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniDiffUpdated",
        group = vim.api.nvim_create_augroup("UserMiniDiffSummary", { clear = true }),
        callback = function(args)
          local buf = args.data and args.data.buf or args.buf
          local summary = vim.b[buf].minidiff_summary
          if not summary then
            return
          end
          local parts = {}
          if (summary.add or 0) > 0 then
            parts[#parts + 1] = "+" .. summary.add
          end
          if (summary.change or 0) > 0 then
            parts[#parts + 1] = "~" .. summary.change
          end
          if (summary.delete or 0) > 0 then
            parts[#parts + 1] = "-" .. summary.delete
          end
          vim.b[buf].minidiff_summary_string = table.concat(parts, " ")
        end,
      })

      local show_dotfiles = true
      local filter_show = function() return true end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local mini_files = require("mini.files")
      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local filter = show_dotfiles and filter_show or filter_hide
        mini_files.refresh({ content = { filter = filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = args.data.buf_id, desc = "Toggle dotfiles" })
        end,
      })
    end,
    keys = {
      {
        "<leader>e",
        function()
          local mf = require("mini.files")
          if mf.close() == nil then
            mf.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        desc = "Mini Files (current file)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Mini Files (cwd)",
      },
      {
        "<leader>fe",
        function()
          require("mini.files").open(LazyVim.root(), true)
        end,
        desc = "Mini Files (root)",
      },
      {
        "<leader>fE",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Mini Files (cwd)",
      },
      {
        "<leader><space>",
        function()
          require("mini.pick").builtin.files({ tool = "git" })
        end,
        desc = "Mini Pick Files (git)",
      },
      {
        "<leader>ff",
        function()
          require("mini.pick").builtin.files()
        end,
        desc = "Mini Pick Files",
      },
      {
        "<leader>fg",
        function()
          require("mini.pick").builtin.grep_live()
        end,
        desc = "Mini Pick Grep",
      },
      {
        "<leader>fr",
        function()
          require("mini.pick").builtin.resume()
        end,
        desc = "Mini Pick Resume",
      },
      {
        "<leader>,",
        function()
          require("mini.pick").builtin.buffers()
        end,
        desc = "Mini Pick Buffers",
      },
      {
        "<leader>fh",
        function()
          require("mini.pick").builtin.help()
        end,
        desc = "Mini Pick Help",
      },
      {
        "<leader>mp",
        function()
          require("mini.diff").toggle_overlay()
        end,
        desc = "Mini Diff Overlay",
      },
      {
        "<leader>ms",
        function()
          return require("mini.diff").operator("apply") .. "gh"
        end,
        expr = true,
        remap = true,
        desc = "Mini Diff Stage Hunk",
      },
      {
        "<leader>mr",
        function()
          return require("mini.diff").operator("reset") .. "gh"
        end,
        expr = true,
        remap = true,
        desc = "Mini Diff Reset Hunk",
      },
      {
        "<leader>mS",
        function()
          require("mini.diff").do_hunks(0, "apply")
        end,
        desc = "Mini Diff Stage Buffer",
      },
      {
        "<leader>mR",
        function()
          require("mini.diff").do_hunks(0, "reset")
        end,
        desc = "Mini Diff Reset Buffer",
      },
      {
        "<leader>mn",
        function()
          require("mini.diff").goto_hunk("next")
        end,
        desc = "Mini Diff Next Hunk",
      },
      {
        "<leader>mN",
        function()
          require("mini.diff").goto_hunk("prev")
        end,
        desc = "Mini Diff Prev Hunk",
      },
      {
        "<leader>mt",
        function()
          require("mini.diff").toggle()
        end,
        desc = "Mini Diff Toggle",
      },
      {
        "<leader>mq",
        function()
          vim.fn.setqflist(require("mini.diff").export("qf", { scope = "all" }))
          vim.cmd("copen")
        end,
        desc = "Mini Diff Quickfix",
      },
      {
        "<leader>ml",
        function()
          vim.fn.setloclist(0, require("mini.diff").export("qf", { scope = "current" }))
          vim.cmd("lopen")
        end,
        desc = "Mini Diff Loclist",
      },
      {
        "<leader>my",
        function()
          return require("mini.diff").operator("yank") .. "gh"
        end,
        expr = true,
        remap = true,
        desc = "Mini Diff Yank Ref Hunk",
      },
    },
  },
}
