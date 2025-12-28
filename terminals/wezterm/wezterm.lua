local wezterm = require('wezterm')
local config = wezterm.config_builder()
local bindings = require('bindings')

config.audible_bell = "Disabled"


config.window_decorations = 'RESIZE'

config.initial_cols = 65
config.initial_rows = 20

config.max_fps = 120

config.front_end = 'WebGpu'
config.webgpu_power_preference = "HighPerformance"

config.font = wezterm.font('Cascadia Code NF')
config.font_size = 11

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8
}

-- config.window_background_opacity = 0.98

config.colors = {
  foreground = '#cac4d4',
  background = '#141118',

  cursor_bg = '#a980db',
  cursor_border = '#a980db',
  cursor_fg = '#141118',

  selection_bg = '#27222f',

  split = "#27222f",

  ansi = {
    "#4f455f",
    "#d66f6f",
    "#6fd692",
    "#d6d36f",
    "#6f9ad6",
    "#9e70d7",
    "#6fd6d6",
    "#f4f3f6"
  },

  brights = {
    "#4f455f",
    "#d66f6f",
    "#6fd692",
    "#d6d36f",
    "#6f9ad6",
    "#9e70d7",
    "#6fd6d6",
    "#f4f3f6"
  },
}

config.window_close_confirmation = 'NeverPrompt'

config.window_padding = {
  left = 32,
  right = 32,
  top = 24,
  bottom = 24,
}

config.enable_tab_bar = false

config.window_frame = {
  font = wezterm.font('Cascadia Code NF'),
}

config.default_prog = { 'pwsh', '-NoLogo' }

config.disable_default_key_bindings = true

config.leader = bindings.leader
config.keys = bindings.keys
config.key_tables = bindings.key_tables
config.mouse_bindings = bindings.mouse_bindings

return config
