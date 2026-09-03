local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()


config.front_end = "OpenGL"
config.max_fps = 144


config.animation_fps = 1
config.cursor_blink_rate = 500


config.term = "xterm-256color"


config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 10.0
config.cell_width = 0.9


config.window_background_opacity = 0.9
config.prefer_egl = true
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}


config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false


config.keys = {
  -- Toggle color scheme
  {
    key = "E",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.EmitEvent("toggle-colorscheme"),
  },
  -- Split pane horizontally
  {
    key = "h",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitPane({
      direction = "Right",
      size = { Percent = 50 },
    }),
  },
  -- Split pane vertically
  {
    key = "v",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitPane({
      direction = "Down",
      size = { Percent = 50 },
    }),
  },
  -- Adjust pane size
  {
    key = "U",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Left", 5 }),
  },
  {
    key = "I",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Down", 5 }),
  },
  {
    key = "O",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Up", 5 }),
  },
  {
    key = "P",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Right", 5 }),
  },
  -- Pane selection
  { key = "9", mods = "CTRL", action = act.PaneSelect },
  -- Show debug overlay
  { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
  -- Toggle window opacity
  {
    key = "O",
    mods = "CTRL|ALT",
    action = wezterm.action_callback(function(window, _)
      local overrides = window:get_config_overrides() or {}
      if overrides.window_background_opacity == 1.0 then
        overrides.window_background_opacity = 0.9
      else
        overrides.window_background_opacity = 1.0
      end
      window:set_config_overrides(overrides)
    end),
  },
}


config.color_scheme_dirs = { 'C:/Users/Sloth/.config/wezterm/colors' }
config.color_scheme = "baskin-pine"


config.default_prog = { "pwsh" }

return config

