-- Pull in the wezterm APIs
local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

local termui = require 'termui'

config.initial_cols = 180
config.initial_rows = 70

config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.96
config.macos_window_background_blur = 42
config.adjust_window_size_when_changing_font_size = false

config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.420,
  brightness = 0.69,
}

-- Cursors
config.cursor_blink_rate = 420
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- Fonts
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font = wezterm.font('JetBrains Mono', { italic = false })
config.font_size = 13

-- Colors
local COLOR = require 'colors'
local color_primary = COLOR.SURFACE
local title_color_bg = color_primary.bg
local title_color_fg = color_primary.fg

config.color_scheme = 'rose-pine'
config.colors = {
  selection_fg = 'none',
  selection_bg = 'rgba(50% 50% 50% 50%)',
}

config.window_frame = {
  active_titlebar_bg = title_color_bg,
  inactive_titlebar_bg = title_color_bg,
  font_size = 13.0,
}

-- Keys
config.keys = {
  -- panes
  { key = '_', mods = 'ALT|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '|', mods = 'ALT|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'x', mods = 'ALT|SHIFT', action = act.CloseCurrentPane { confirm = true } },
  { key = 'o', mods = 'ALT|SHIFT', action = act.RotatePanes 'Clockwise' },
  { key = 'LeftArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 2 } },
  { key = 'RightArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 2 } },
  { key = 'UpArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 2 } },
  { key = 'DownArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 2 } },
  { key = 'Enter', mods = 'ALT|SHIFT', action = act.TogglePaneZoomState },

  -- Scrollback
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = act.ClearScrollback 'ScrollbackOnly',
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
}

-- Mouse
config.mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- Register custom event handlers
termui.registerEventHandlers(title_color_bg, title_color_fg)

return config
