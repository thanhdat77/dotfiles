return {
  "nvim-mini/mini.starter",
  opts = function(_, opts)
    local starter = require("mini.starter")
    local pad = string.rep(" ", 22)

    opts.items = vim.list_extend(opts.items or {}, {
      starter.sections.recent_files(5, false, false),
    })

    opts.content_hooks = {
      starter.gen_hook.adding_bullet(pad .. "░ ", false),
      starter.gen_hook.aligning("center", "center"),
    }

    return opts
  end,
  config = function(_, config)
    -- Don't open starter when args passed (nvim ., nvim file.txt)
    if vim.fn.argc() > 0 then
      require("mini.starter").setup(config)
      return
    end

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    local starter = require("mini.starter")
    starter.setup(config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function(ev)
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local pad_footer = string.rep(" ", 8)
        starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        if vim.bo[ev.buf].filetype == "ministarter" then
          pcall(starter.refresh)
        end
      end,
    })
  end,
}
