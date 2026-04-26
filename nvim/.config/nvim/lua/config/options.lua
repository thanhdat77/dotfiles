-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Function to clear backgrounds
local function transparent_back()
  local groups = { "Normal", "NormalNC", "SignColumn", "NormalFloat", "StatusLine" }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
  end
end

-- Run it now and whenever you change a colorscheme
transparent_back()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = transparent_back,
})