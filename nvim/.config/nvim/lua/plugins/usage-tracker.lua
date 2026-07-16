return {
  {
    dir = vim.fn.stdpath("config"),
    name = "usage-tracker",
    lazy = false,
    priority = 1000,
    init = function()
      local state_file = vim.fn.stdpath("state") .. "/plugin-usage.json"
      local original_keymap_set = vim.keymap.set
      local max_recent = 500

      local plugin_map = {
        Gitsigns = "gitsigns.nvim",
        ClaudeCode = "claudecode.nvim",
        ClaudeCodeFocus = "claudecode.nvim",
        ClaudeCodeAdd = "claudecode.nvim",
        ClaudeCodeSend = "claudecode.nvim",
        ClaudeCodeTreeAdd = "claudecode.nvim",
        ClaudeCodeDiffAccept = "claudecode.nvim",
        ClaudeCodeDiffDeny = "claudecode.nvim",
        Obsidian = "obsidian.nvim",
        Yazi = "yazi.nvim",
        Lazy = "lazy.nvim",
        Telescope = "telescope.nvim",
        Snacks = "snacks.nvim",
      }

      -- Still record these in all_commands/recent, but don't count them as
      -- meaningful plugin usage.
      local noisy_commands = {
        q = true,
        qa = true,
        qall = true,
        quit = true,
        quitall = true,
        w = true,
        write = true,
        wq = true,
        x = true,
        xa = true,
        wa = true,
        wall = true,
        e = true,
        edit = true,
      }

      local state = {
        commands = {},
        all_commands = {},
        plugins = {},
        keymaps = {},
        filetypes = {},
        files = {},
        lsp = {},
        searches = {},
        yanks = {},
        events = {},
        recent = {},
      }

      local function is_list(t)
        return type(t) == "table" and vim.tbl_islist(t)
      end

      local function as_bucket(value)
        if type(value) ~= "table" or is_list(value) then
          return {}
        end
        return value
      end

      local function as_list(value)
        if type(value) ~= "table" or not is_list(value) then
          return {}
        end
        return value
      end

      local function now()
        return os.date("%Y-%m-%d %H:%M:%S")
      end

      local function bump(bucket, key)
        if not key or key == "" then
          return
        end
        bucket[key] = (bucket[key] or 0) + 1
      end

      local function log_event(kind, value, extra)
        value = tostring(value or "")
        if value == "" then
          return
        end
        state.recent[#state.recent + 1] = {
          time = now(),
          kind = kind,
          value = value,
          extra = extra,
        }
        while #state.recent > max_recent do
          table.remove(state.recent, 1)
        end
      end

      local function read_state()
        local ok, lines = pcall(vim.fn.readfile, state_file)
        if not ok or not lines or vim.tbl_isempty(lines) then
          return
        end
        local ok_decode, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
        if type(decoded) == "table" and ok_decode then
          state.commands = as_bucket(decoded.commands)
          state.all_commands = as_bucket(decoded.all_commands)
          state.plugins = as_bucket(decoded.plugins)
          state.keymaps = as_bucket(decoded.keymaps)
          state.filetypes = as_bucket(decoded.filetypes)
          state.files = as_bucket(decoded.files)
          state.lsp = as_bucket(decoded.lsp)
          state.searches = as_bucket(decoded.searches)
          state.yanks = as_bucket(decoded.yanks)
          state.events = as_bucket(decoded.events)
          state.recent = as_list(decoded.recent)
        end
      end

      local function write_state()
        vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
        vim.fn.writefile(vim.split(vim.json.encode(state), "\n"), state_file)
      end

      local function normalize_command(cmdline)
        local cmd = vim.trim(cmdline or "")
        if cmd == "" then
          return nil
        end
        cmd = cmd:gsub("^['<,'>%%0-9%s]+", "")
        local name = cmd:match("^([A-Za-z][A-Za-z0-9_]*)")
        return name, cmd
      end

      local function infer_plugin(text)
        text = tostring(text or "")
        local lower = text:lower()
        if lower:find("yazi") then
          return "yazi.nvim"
        end
        if lower:find("lazygit") or lower:find("lazy git") then
          return "lazygit"
        end
        if lower:find("gitsigns") or lower:find("git hunk") or lower:find("blame") or lower:find("diffthis") then
          return "gitsigns.nvim"
        end
        if lower:find("mini diff") then
          return "mini.diff"
        end
        if lower:find("mini files") then
          return "mini.files"
        end
        if lower:find("mini pick") then
          return "mini.pick"
        end
        if lower:find("claude") then
          return "claudecode.nvim"
        end
        if lower:find("snacks") then
          return "snacks.nvim"
        end
        if lower:find("lazy") then
          return "lazy.nvim"
        end
        return nil
      end

      local function track_command(name, raw)
        if not name then
          return
        end
        bump(state.all_commands, name)
        log_event("command", raw or name)
        if noisy_commands[name] then
          return
        end
        bump(state.commands, name)
        bump(state.plugins, plugin_map[name] or infer_plugin(name) or name)
      end

      local function track_keymap(lhs, opts)
        opts = opts or {}
        local desc = opts.desc or lhs
        local key = desc and (lhs .. " — " .. desc) or lhs
        bump(state.keymaps, key)
        bump(state.plugins, infer_plugin(desc) or infer_plugin(lhs) or "keymap")
        log_event("keymap", key)
      end

      local function top_lines(title, bucket)
        local items = {}
        for name, count in pairs(bucket or {}) do
          if type(count) == "number" then
            items[#items + 1] = { name = name, count = count }
          end
        end
        table.sort(items, function(a, b)
          if a.count == b.count then
            return a.name < b.name
          end
          return a.count > b.count
        end)

        local lines = { title }
        if vim.tbl_isempty(items) then
          lines[#lines + 1] = "  (no data yet)"
          return lines
        end

        for i, item in ipairs(items) do
          if i > 15 then
            break
          end
          lines[#lines + 1] = string.format("  %2d. %-48s %d", i, item.name, item.count)
        end
        return lines
      end

      local function recent_lines()
        local lines = { "Recent events:" }
        if vim.tbl_isempty(state.recent) then
          lines[#lines + 1] = "  (no data yet)"
          return lines
        end
        local start = math.max(1, #state.recent - 14)
        for i = start, #state.recent do
          local event = state.recent[i]
          lines[#lines + 1] = string.format(
            "  %s %-10s %s",
            event.time or "",
            event.kind or "event",
            event.value or ""
          )
        end
        return lines
      end

      read_state()

      -- Track most user keymaps. Function mappings are wrapped safely. Simple
      -- <cmd>...<cr> string mappings are wrapped to preserve behavior and count use.
      vim.keymap.set = function(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("force", {}, opts or {})
        if type(lhs) ~= "string" then
          return original_keymap_set(mode, lhs, rhs, opts)
        end

        if type(rhs) == "function" then
          local original_rhs = rhs
          rhs = function(...)
            track_keymap(lhs, opts)
            return original_rhs(...)
          end
        elseif type(rhs) == "string" then
          local cmd = rhs:match("^<cmd>(.*)<cr>$") or rhs:match("^<Cmd>(.*)<CR>$")
          if cmd then
            local original_cmd = cmd
            rhs = function()
              track_keymap(lhs, opts)
              vim.cmd(original_cmd)
            end
          end
        end

        return original_keymap_set(mode, lhs, rhs, opts)
      end

      vim.api.nvim_create_autocmd("CmdlineLeave", {
        group = vim.api.nvim_create_augroup("UserPluginUsageTrackerCommands", { clear = true }),
        callback = function()
          local cmdtype = vim.fn.getcmdtype()
          if cmdtype == ":" then
            local name, raw = normalize_command(vim.fn.histget("cmd", -1))
            track_command(name, raw)
          elseif cmdtype == "/" or cmdtype == "?" then
            local query = vim.fn.histget("search", -1)
            if query and query ~= "" then
              bump(state.searches, query)
              log_event("search", query, cmdtype)
            end
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("UserPluginUsageTrackerFiles", { clear = true }),
        callback = function(args)
          local name = vim.api.nvim_buf_get_name(args.buf)
          if name and name ~= "" then
            local display = vim.fn.fnamemodify(name, ":~:.")
            bump(state.files, display)
            log_event("file", display)
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserPluginUsageTrackerFiletypes", { clear = true }),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft and ft ~= "" then
            bump(state.filetypes, ft)
            log_event("filetype", ft)
          end
        end,
      })

      vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("UserPluginUsageTrackerYanks", { clear = true }),
        callback = function()
          local op = vim.v.event and vim.v.event.operator or "y"
          local kind = op == "y" and "yank" or op
          bump(state.yanks, kind)
          log_event("yank", kind)
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserPluginUsageTrackerLsp", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name then
            bump(state.lsp, client.name)
            bump(state.plugins, "lsp:" .. client.name)
            log_event("lsp", client.name)
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = { "LazyLoad", "MiniDiffUpdated", "MiniFilesBufferCreate", "VeryLazy" },
        group = vim.api.nvim_create_augroup("UserPluginUsageTrackerEvents", { clear = true }),
        callback = function(args)
          local value = args.match
          if args.match == "LazyLoad" and args.data and args.data then
            value = "LazyLoad:" .. tostring(args.data)
          end
          bump(state.events, value)
          log_event("event", value)
        end,
      })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("UserPluginUsageTrackerPersist", { clear = true }),
        callback = write_state,
      })

      vim.api.nvim_create_user_command("PluginUsage", function()
        write_state()
        local lines = {}
        vim.list_extend(lines, top_lines("Plugin usage:", state.plugins))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("Keymaps:", state.keymaps))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("Meaningful commands:", state.commands))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("All commands:", state.all_commands))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("Filetypes:", state.filetypes))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("Files:", state.files))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("LSP:", state.lsp))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("Searches:", state.searches))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("Yanks:", state.yanks))
        lines[#lines + 1] = ""
        vim.list_extend(lines, top_lines("Events:", state.events))
        lines[#lines + 1] = ""
        vim.list_extend(lines, recent_lines())
        vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Plugin Usage" })
      end, { desc = "Show tracked plugin/keymap/file/search/LSP usage" })

      vim.api.nvim_create_user_command("PluginUsageReset", function()
        state.commands = {}
        state.all_commands = {}
        state.plugins = {}
        state.keymaps = {}
        state.filetypes = {}
        state.files = {}
        state.lsp = {}
        state.searches = {}
        state.yanks = {}
        state.events = {}
        state.recent = {}
        write_state()
        vim.notify("Plugin usage reset", vim.log.levels.INFO, { title = "Plugin Usage" })
      end, { desc = "Reset tracked plugin/keymap/file/search/LSP usage" })
    end,
  },
}
