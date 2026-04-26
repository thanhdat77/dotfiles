local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- [CƠ BẢN & FONT]
config.font = wezterm.font('JetBrainsMonoNL Nerd Font', { weight = 600 })
config.font_size = 12.0
config.line_height = 1 
config.color_scheme = 'One Light (Gogh)'


local main_color = "#c5b087"
local main_color_dark = "#b39b6f" 

-- [WINDOW & GIAO DIỆN]
config.window_padding = { left = 15, right = 15, top = 15, bottom = 10 }
config.window_background_opacity = 1.0


config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_close_confirmation = 'AlwaysPrompt'

config.window_frame = {
  font = wezterm.font({ family = 'JetBrainsMonoNL Nerd Font', weight = 'Bold' }),
  active_titlebar_bg = '#ffffff',
  inactive_titlebar_bg = '#f6f8fa',
}

-- [TAB BAR]
config.use_fancy_tab_bar = true 
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = false

config.colors = {
  tab_bar = {
    background = '#f6f8fa',
    active_tab = { bg_color = main_color, fg_color = '#ffffff' },
    inactive_tab = { bg_color = '#f6f8fa', fg_color = '#586069' },
    inactive_tab_hover = { bg_color = main_color_dark, fg_color = '#ffffff' },
    -- Nút New Tab (+)
    new_tab = { bg_color = '#f6f8fa', fg_color = '#586069' },
    new_tab_hover = { bg_color = main_color_dark, fg_color = '#ffffff' },
  },
}



config.automatically_reload_config = true
config.scrollback_lines = 5000

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Chia màn hình (Split)
  { mods = 'LEADER', key = 'v', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { mods = 'LEADER', key = 'h', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- Phóng to 1 pane (Maximize)
  { mods = 'LEADER', key = 'z', action = wezterm.action.TogglePaneZoomState },
  -- Di chuyển giữa các Tab nhanh
  { mods = 'ALT', key = '1', action = wezterm.action.ActivateTab(0) },
  { mods = 'ALT', key = '2', action = wezterm.action.ActivateTab(1) },
  { mods = 'ALT', key = '3', action = wezterm.action.ActivateTab(2) },
}


config.disable_default_mouse_bindings = false


config.front_end = "WebGpu" -- Dùng GPU để render, cực mượt


return config