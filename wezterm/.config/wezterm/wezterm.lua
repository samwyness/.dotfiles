-- Pull in the wezterm APIs
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

local termui = require("termui")

config.initial_cols = 210
config.initial_rows = 69

config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.macos_window_background_blur = 20
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
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Fonts
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font = wezterm.font("JetBrains Mono", { italic = false })

-- Colors
local COLOR = require("colors")
local color_primary = COLOR.SURFACE
local title_color_bg = color_primary.bg
local title_color_fg = color_primary.fg

config.color_scheme = "rose-pine"
config.colors = {
	selection_fg = "none",
	selection_bg = "rgba(50% 50% 50% 50%)",
}

config.window_frame = {
	active_titlebar_bg = title_color_bg,
	inactive_titlebar_bg = title_color_bg,
	font_size = 12.0,
}

-- Keys
config.keys = {
	-- Panes
	{ key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "q", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "o", mods = "CTRL|SHIFT", action = act.RotatePanes("Clockwise") },
	{ key = "r", mods = "CTRL|SHIFT", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	{ key = "Enter", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

	-- Scrollback
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = act.ClearScrollback("ScrollbackOnly"),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = act.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
}

-- Key tables
config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- Register custom event handlers
termui.registerEventHandlers(title_color_bg, title_color_fg)

return config
