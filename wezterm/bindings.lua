local wezterm = require('wezterm')
local act = wezterm.action

local keys = {
  -- misc/useful --
  { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
  { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
  { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
  { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
  {
    key = 'F5',
    mods = 'NONE',
    action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
  },
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
  { key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },
  { key = 'f',   mods = 'CTRL', action = act.Search({ CaseInSensitiveString = '' }) },
  {
    key = 'u',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs({
      label = 'open url',
      patterns = {
        '\\((https?://\\S+)\\)',
        '\\[(https?://\\S+)\\]',
        '\\{(https?://\\S+)\\}',
        '<(https?://\\S+)>',
        '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info('opening: ' .. url)
        wezterm.open_with(url)
      end),
    }),
  },

  -- cursor movement --
  { key = 'LeftArrow',  mods = 'CTRL',       action = act.SendString '\u{1b}OH' },
  { key = 'RightArrow', mods = 'CTRL',       action = act.SendString '\u{1b}OF' },
  { key = 'Backspace',  mods = 'CTRL',       action = act.SendString '\u{15}' },
  { key = 'k',          mods = 'ALT',        action = act.ScrollByLine(-1) },
  { key = 'j',          mods = 'ALT',        action = act.ScrollByLine(1) },
  { key = 'k',          mods = 'ALT|SHIFT',  action = act.ScrollByPage(-0.5) },
  { key = 'j',          mods = 'ALT|SHIFT',  action = act.ScrollByPage(0.5) },

  -- copy/paste --
  { key = 'c',          mods = 'CTRL',       action = act.CopyTo('Clipboard') },
  { key = 'v',          mods = 'CTRL',       action = act.PasteFrom('Clipboard') },

  -- tabs --
  -- tabs: spawn+close
  { key = 't',          mods = 'CTRL|SHIFT', action = act.SpawnTab('DefaultDomain') },
  { key = 'w',          mods = 'CTRL|SHIFT', action = act.CloseCurrentTab({ confirm = false }) },

  -- tabs: navigation
  { key = '[',          mods = 'CTRL',       action = act.ActivateTabRelative(-1) },
  { key = ']',          mods = 'CTRL',       action = act.ActivateTabRelative(1) },
  { key = '[',          mods = 'CTRL|SHIFT', action = act.MoveTabRelative(-1) },
  { key = ']',          mods = 'CTRL|SHIFT', action = act.MoveTabRelative(1) },

  -- window --
  -- window: spawn windows
  { key = 'n',          mods = 'CTRL|SHIFT', action = act.SpawnWindow },

  -- window: zoom window
  {
    key = '-',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, _pane)
      local dimensions = window:get_dimensions()
      if dimensions.is_full_screen then
        return
      end
      local new_width = dimensions.pixel_width - 50
      local new_height = dimensions.pixel_height - 50
      window:set_inner_size(new_width, new_height)
    end)
  },
  {
    key = '=',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, _pane)
      local dimensions = window:get_dimensions()
      if dimensions.is_full_screen then
        return
      end
      local new_width = dimensions.pixel_width + 50
      local new_height = dimensions.pixel_height + 50
      window:set_inner_size(new_width, new_height)
    end)
  },
  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, _pane)
      window:maximize()
    end)
  },

  -- panes --
  -- panes: split panes
  {
    key = [[\]],
    mods = 'CTRL',
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = [[\]],
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },

  -- panes: zoom+close pane
  { key = 'Enter', mods = 'CTRL',       action = act.TogglePaneZoomState },
  { key = 'w',     mods = 'CTRL',       action = act.CloseCurrentPane({ confirm = false }) },

  -- panes: navigation
  { key = 'k',     mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Up') },
  { key = 'j',     mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Down') },
  { key = 'h',     mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Left') },
  { key = 'l',     mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Right') },
  {
    key = 'p',
    mods = 'CTRL|SHIFT',
    action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
  },

  -- panes: scroll pane
  { key = 'u',        mods = 'CTRL', action = act.ScrollByLine(-5) },
  { key = 'd',        mods = 'CTRL', action = act.ScrollByLine(5) },
  { key = 'PageUp',   mods = 'NONE', action = act.ScrollByPage(-0.75) },
  { key = 'PageDown', mods = 'NONE', action = act.ScrollByPage(0.75) },
}

-- stylua: ignore
local key_tables = {
  resize_font = {
    { key = 'k',      action = act.IncreaseFontSize },
    { key = 'j',      action = act.DecreaseFontSize },
    { key = 'r',      action = act.ResetFontSize },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
}

local mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

return {
  disable_default_key_bindings = true,
  -- disable_default_mouse_bindings = true,
  leader = { key = 'Space', mods = 'CTRL' },
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}
