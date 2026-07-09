return {
    "nvim-mini/mini.starter",
    opts = function(_, opts)
        local starter = require("mini.starter")
        local pad = string.rep(" ", 22)

        local fenix_header = {
            "█████▒▓█████  ███▄    █  ██▓▒██   ██▒",
            "▓██   ▒▓█   ▀  ██ ▀█   █ ▓██▒▒▒ █ █ ▒░",
            "▒████ ░▒███   ▓██  ▀█ ██▒▒██▒░░  █   ░",
            "░▓█▒  ░▒▓█  ▄ ▓██▒  ▐▌██▒░██░ ░ █ █ ▒ ",
            "░▒█░   ░▒████▒▒██░   ▓██░░██░▒██▒ ▒██▒",
            " ▒ ░   ░░ ▒░ ░░ ▒░   ▒ ▒ ░▓  ▒▒ ░ ░▓ ░",
            " ░      ░ ░  ░░ ░░   ░ ▒░ ▒ ░░░   ░▒ ░",
            " ░ ░      ░      ░   ░ ░  ▒ ░ ░    ░  ",
        }
        opts.header = table.concat(vim.list_extend({ "" }, vim.list_extend(fenix_header, { "" })), "\n")

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

        local header_groups = {
            "FenixHeader1",
            "FenixHeader2",
            "FenixHeader3",
            "FenixHeader4",
            "FenixHeader5",
            "FenixHeader6",
            "FenixHeader7",
            "FenixHeader8",
        }

        local function set_header_highlights()
            local colors = {
                "#1d4ed8",
                "#2563eb",
                "#3b82f6",
                "#60a5fa",
                "#8b5cf6",
                "#a78bfa",
                "#c4b5fd",
                "#ddd6fe",
            }
            for i, group in ipairs(header_groups) do
                vim.api.nvim_set_hl(0, group, { fg = colors[i], bold = true })
            end
        end
        set_header_highlights()
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("FenixStarterHeaderColors", { clear = true }),
            callback = set_header_highlights,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniStarterOpened",
            group = vim.api.nvim_create_augroup("FenixStarterHeaderPaint", { clear = true }),
            callback = function(args)
                local buf = args.data and args.data.buf_id or vim.api.nvim_get_current_buf()
                for i, group in ipairs(header_groups) do
                    vim.api.nvim_buf_add_highlight(buf, -1, group, i, 0, -1)
                end
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function(ev)
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                local pad_footer = string.rep(" ", 8)
                starter.config.footer = pad_footer
                    .. "⚡ Neovim loaded "
                    .. stats.count
                    .. " plugins in "
                    .. ms
                    .. "ms"
                if vim.bo[ev.buf].filetype == "ministarter" then
                    pcall(starter.refresh)
                end
            end,
        })
    end,
}
