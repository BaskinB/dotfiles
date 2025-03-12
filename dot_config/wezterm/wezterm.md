---
title: "Wezterm Config"
author: "BaskinB"
tangle: "./wezterm/wezterm.lua"
---

# Wezterm Config <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->

- [About this Config](#about-this-config)
  - [Main Settings](#main-settings)
  - [Performance settings](#performance-settings)
  - [Animation settings](#animation-settings)
  - [Terminal settings](#terminal-settings)
  - [Font settings](#font-settings)
  - [Window settings](#window-settings)
  - [Tab bar settings](#tab-bar-settings)
  - [Key bindings](#key-bindings)
  - [Color scheme settings](#color-scheme-settings)
  - [Default program/return the Config Table](#default-programreturn-the-config-table)


## About this Config

This is a literate configuration file for the WezTerm terminal emulator, WezTerm is a powerful cross-platform terminal emulator and multiplexer written by [@wez](https://github.com/wez) and implemented in [*Rust*](https://www.rust-lang.org/) that is a really nice highly configurable terminal emulator and my terminal of choice.

### Main Settings

```lua
local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()
```

### Performance settings

```lua
config.front_end = "OpenGL"
config.max_fps = 144
```

### Animation settings

```lua
config.animation_fps = 1
config.cursor_blink_rate = 500
```

### Terminal settings

```lua
config.term = "xterm-256color"
```

### Font settings

```lua
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 10.0
config.cell_width = 0.9
```

### Window settings

```lua
config.window_background_opacity = 0.9
config.prefer_egl = true
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
```

### Tab bar settings

```lua
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
```

### Key bindings

| Key | Mods | Action |
| --- | ---- | ------ |
| E | CTRL+SHIFT+ALT | Toggle color scheme |
| h | CTRL+SHIFT+ALT | Split pane horizontally |
| v | CTRL+SHIFT+ALT | Split pane vertically |
| U | CTRL+SHIFT | Adjust pane size (Left) |
| I | CTRL+SHIFT | Adjust pane size (Down) |
| O | CTRL+SHIFT | Adjust pane size (Up) |
| P | CTRL+SHIFT | Adjust pane size (Right) |
| 9 | CTRL | Pane selection |
| L | CTRL | Show debug overlay |
| O | CTRL+ALT | Toggle window opacity |

```lua
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
```

### Color scheme settings

```lua
config.color_scheme_dirs = { 'C:/Users/Sloth/.config/wezterm/colors' }
config.color_scheme = "baskin-pine"
```

### Default program/return the Config Table

```lua
config.default_prog = { "pwsh" }

return config
```
