-- Use GitHub Plus Light style
local ok, _ = pcall(vim.cmd, "colorscheme github_light_default")

if not ok then
  vim.notify("GitHub Light Default theme not found!", vim.log.levels.WARN)
end

