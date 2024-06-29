local wezterm = require("wezterm")

local color_default_fg_light = wezterm.color.parse("#cacaca") -- 💩

return {
	SURFACE = {
		bg = wezterm.color.parse("#2a273f"),
		fg = color_default_fg_light,
	},
	ROSE = {
		bg = wezterm.color.parse("#d7827e"),
		fg = color_default_fg_light,
	},
	PINE = {
		bg = wezterm.color.parse("#286983"),
		fg = color_default_fg_light,
	},
	FOAM = {
		bg = wezterm.color.parse("#56949f"),
		fg = color_default_fg_light,
	},
	IRIS = {
		bg = wezterm.color.parse("#907aa9"),
		fg = color_default_fg_light,
	},
}
