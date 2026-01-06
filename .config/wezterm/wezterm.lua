-- WezTerm configuration
-- https://wezfurlong.org/wezterm/

local wezterm = require 'wezterm'
local config = {}

-- Use config builder for better error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font configuration (matching Ghostty)
config.font = wezterm.font_with_fallback({
  { family = 'Hasklug Nerd Font Mono', weight = 'Medium' },
  'JetBrains Mono',
})
config.font_size = 16.0
config.line_height = 1.1
config.cell_width = 0.95

-- Color scheme (matching Ghostty theme)
config.colors = {
  background = '#080a0c',
  foreground = '#00ff41',
  cursor_bg = '#a7cfaf',
  cursor_border = '#a7cfaf',

  ansi = {
    '#0f1419', -- black
    '#da858e', -- red
    '#b7ce97', -- green
    '#dab183', -- yellow
    '#a3b8c6', -- blue
    '#c0aed2', -- purple
    '#a7cfbd', -- cyan
    '#e9e9e2', -- white
  },
  brights = {
    '#505e62', -- bright black
    '#da858e', -- bright red
    '#b7ce97', -- bright green
    '#dab183', -- bright yellow
    '#a3b8c6', -- bright blue
    '#c0aed2', -- bright purple
    '#a7cfbd', -- bright cyan
    '#e9e9e2', -- bright white
  },
}

-- Window appearance
config.window_background_opacity = 0.9
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 25,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Window native maximized on startup
config.native_macos_fullscreen_mode = false

-- Add event handler to maximize window on startup
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Cursor
config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 0

-- Misc
config.audible_bell = 'Disabled'
config.automatically_reload_config = true
config.check_for_updates = false
config.window_close_confirmation = 'NeverPrompt'
config.quit_when_all_windows_are_closed = true

-- Keybindings
config.keys = {
  -- Cmd+1-9: Send Ctrl+Space then number for Zellij tab switching
  { key = '1', mods = 'CMD', action = wezterm.action.SendString('\x001') },
  { key = '2', mods = 'CMD', action = wezterm.action.SendString('\x002') },
  { key = '3', mods = 'CMD', action = wezterm.action.SendString('\x003') },
  { key = '4', mods = 'CMD', action = wezterm.action.SendString('\x004') },
  { key = '5', mods = 'CMD', action = wezterm.action.SendString('\x005') },
  { key = '6', mods = 'CMD', action = wezterm.action.SendString('\x006') },
  { key = '7', mods = 'CMD', action = wezterm.action.SendString('\x007') },
  { key = '8', mods = 'CMD', action = wezterm.action.SendString('\x008') },
  { key = '9', mods = 'CMD', action = wezterm.action.SendString('\x009') },

  -- Reload config
  { key = 'r', mods = 'CMD', action = wezterm.action.ReloadConfiguration },
  { key = 'r', mods = 'CTRL', action = wezterm.action.ReloadConfiguration },

  -- Clear screen
  { key = 'k', mods = 'CMD', action = wezterm.action.ClearScrollback('ScrollbackAndViewport') },
  { key = 'k', mods = 'CTRL', action = wezterm.action.ClearScrollback('ScrollbackAndViewport') },

  -- Copy/Paste
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo('Clipboard') },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom('Clipboard') },

  -- Shift+Enter sends newline
  { key = 'Enter', mods = 'SHIFT', action = wezterm.action.SendString('\n') },
}

-- Option key behavior (right option as Alt)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

return config
