-- Pull in the wezterm APIs
local wezterm = require 'wezterm'
local mux = wezterm.mux

local ICONS = require 'icons'

local function registerEventHandlers(title_color_bg, title_color_fg)
  -- Thanks @gsuuon
  -- https://gist.github.com/gsuuon/5511f0aa10c10c6cbd762e0b3e596b71
  wezterm.on('update-right-status', function(window)
    local color_off = title_color_bg:lighten(0.4)
    local color_on = color_off:lighten(0.4)

    local bat = ''
    local b = wezterm.battery_info()[1]

    bat = wezterm.format {
      { Foreground = {
        Color = b.state_of_charge > 0.2 and color_on or color_off,
      } },
      { Text = '▉' },
      { Foreground = {
        Color = b.state_of_charge > 0.4 and color_on or color_off,
      } },
      { Text = '▉' },
      { Foreground = {
        Color = b.state_of_charge > 0.6 and color_on or color_off,
      } },
      { Text = '▉' },
      { Foreground = {
        Color = b.state_of_charge > 0.8 and color_on or color_off,
      } },
      { Text = '▉' },
      {
        Background = {
          Color = b.state_of_charge > 0.98 and color_on or color_off,
        },
      },
      {
        Foreground = {
          Color = b.state == 'Charging' and color_on:lighten(0.8):complement()
            or (b.state_of_charge < 0.5 and wezterm.GLOBAL.count % 2 == 0) and color_on
              :lighten(0.4)
              :complement()
            or color_off:darken(0.4),
        },
      },
      { Text = ' ⚡ ' },
    }

    local time = wezterm.strftime '%-l:%M %P'

    local bg1 = title_color_bg:lighten(0.1)
    local bg2 = title_color_bg:lighten(0.2)

    window:set_right_status(wezterm.format {
      { Background = { Color = title_color_bg } },
      { Foreground = { Color = bg1 } },
      { Text = '' },
      { Background = { Color = title_color_bg:lighten(0.1) } },
      { Foreground = { Color = title_color_fg } },
      { Text = ' ' .. window:active_workspace() .. ' ' },
      { Foreground = { Color = bg1 } },
      { Background = { Color = bg2 } },
      { Text = '' },
      { Foreground = { Color = title_color_bg:lighten(0.4) } },
      { Foreground = { Color = title_color_fg } },
      { Text = ' ' .. time .. ' ' .. bat },
    })
  end)

  -- On startup reposition the window to the top left
  wezterm.on('gui-startup', function(cmd)
    local args = {}
    if cmd then
      args = cmd.args
    end

    local tab = mux.spawn_window(cmd or {
      args = args,
      position = {
        x = 50,
        y = 105,
      },
    })

    tab:set_title('  ' .. ICONS[math.random(#ICONS)] .. '  ')
  end)

  wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
    local TAB_EDGE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
    local TAB_EDGE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick

    local edge_background = title_color_bg
    local background = title_color_bg:lighten(0.05)
    local foreground = title_color_fg

    if tab.is_active then
      background = background:lighten(0.1)
      foreground = foreground:lighten(0.1)
    elseif hover then
      background = background:lighten(0.2)
      foreground = foreground:lighten(0.2)
    end

    local edge_foreground = background

    local title = tab.tab_title

    if title and #title < 1 then
      title = tab.active_pane.title:gsub('%.exe', '')
    end

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = TAB_EDGE_LEFT },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = TAB_EDGE_RIGHT },
    }
  end)
end

return {
  registerEventHandlers = registerEventHandlers,
}
