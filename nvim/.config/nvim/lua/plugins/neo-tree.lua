return {
  "nvim-neo-tree/neo-tree.nvim",
  config = function(_, opts)
    require("neo-tree").setup(opts)
    local hl = function()
      local get = function(group, attr)
        return vim.api.nvim_get_hl(0, { name = group, link = false })[attr]
      end
      local fg = function(g) return { fg = get(g, "fg") } end

      vim.api.nvim_set_hl(0, "NeoTreeNormal",        { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC",      { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer",   { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator",  { bg = "NONE", fg = get("WinSeparator", "fg") })
      vim.api.nvim_set_hl(0, "NeoTreeRootName",      { fg = get("Special", "fg"), bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", fg("Directory"))
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", fg("Directory"))
      vim.api.nvim_set_hl(0, "NeoTreeFileName",      fg("Normal"))
      vim.api.nvim_set_hl(0, "NeoTreeFileIcon",      fg("Comment"))
      vim.api.nvim_set_hl(0, "NeoTreeIndentMarker",  fg("NonText"))
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine",    { bg = get("CursorLine", "bg") })
      vim.api.nvim_set_hl(0, "NeoTreeGitAdded",      fg("GitSignsAdd"))
      vim.api.nvim_set_hl(0, "NeoTreeGitModified",   fg("GitSignsChange"))
      vim.api.nvim_set_hl(0, "NeoTreeGitDeleted",    fg("GitSignsDelete"))
      vim.api.nvim_set_hl(0, "NeoTreeGitUntracked",  fg("GitSignsAdd"))
      vim.api.nvim_set_hl(0, "NeoTreeGitIgnored",    fg("Comment"))
      vim.api.nvim_set_hl(0, "NeoTreeGitConflict",   { fg = get("DiagnosticError", "fg"), bold = true })
    end
    hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = hl })
  end,
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
