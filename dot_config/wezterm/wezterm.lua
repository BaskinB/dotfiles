
local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

--local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

config.default_cwd = wezterm.home_dir
config.default_workspace = "main"
config.set_environment_variables = {
  WEZTERM_PREFER_WORKING_DIRECTORY = "true",
  TERM_PROGRAM = "WezTerm",
  WEZTERM_EXECUTED = "1",
}

-- Choose a theme with a specific color (for default)
config.color_scheme = "baskin-pine"

local custom_colors = {
  red = "#e06c75",
  cyan = "#56b6c2",
  magenta = "#c678dd",
  yellow = "#e5c07b",
}

config.colors = {
  foreground = '#cdd6f4',
  background = '#140e1a',

  cursor_bg = '#7dd3fc',
  cursor_border = '#7dd3fc',

  selection_bg = '#1a1e27',
  selection_fg = '#cdd6f4',

  tab_bar = {
    background = '#191120',

    active_tab = {
      bg_color = '#140e1a',
      fg_color = '#7dd3fc',
    },

    inactive_tab = {
      bg_color = '#191120',
      fg_color = '#6b7280',
    },
    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#191120',
      fg_color = '#ffffff',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

-- ============================================================================
-- WINDOW DAN APPEARANCE
-- ============================================================================

-- Window styling
config.window_decorations = 'TITLE|RESIZE'
config.window_frame = {
  active_titlebar_bg = "#191120",
  inactive_titlebar_bg = "#191120",
  button_bg = '#1a1e27',
  button_hover_bg = '#2a2f38',
}

config.use_resize_increments = false

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

config.window_content_alignment = {
  horizontal = 'Center',
  vertical = 'Center',
}

-- Default window size
config.initial_cols = 130
config.initial_rows = 30

-- ============================================================================
-- FONT CONFIGURATION
-- ============================================================================

config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font', weight = "Bold" },
}

config.font_size = 13.0
config.cell_width = 0.95
config.line_height = 1.0

-- ============================================================================
-- TAB BAR STYLING
-- ============================================================================

config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true

-- Tab bar with padding and styling
config.tab_max_width = 32

-- ============================================================
-- Tab titles: pill-shaped, rounded caps that "melt" into the bar bg
-- ============================================================
-- Helper function to get just the process name instead of the full path
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = ''

  -- 1. Check for manual rename
  if tab.tab_title and #tab.tab_title > 0 then
    title = tab.tab_title
  else
    -- 2. Fall back to process name
    local pane = tab.active_pane
    title = basename(pane.foreground_process_name or '')
  end

  -- 4. Append the tab index (adding 1 makes it 1-indexed instead of 0-indexed)
  local index = tab.tab_index + 1

  return {
    { Text = ' ' .. index .. ': ' .. title .. ' ' },
  }
end)
-- ============================================================================
-- KEYBINDINGS
-- ============================================================================
config.leader = { key = "e", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  -- Session Management
  {
    key = "s",
    mods = "LEADER",
    action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES|LAUNCH_MENU_ITEMS" }),
  },
  -- Tab management
  { key = "t",   mods = "LEADER|SHIFT", action = act.ShowTabNavigator },
  { key = 't',   mods = 'LEADER',       action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',   mods = 'LEADER',       action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'Tab', mods = 'LEADER',       action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'LEADER',       action = wezterm.action.ActivateTabRelative(-1) },
  { key = ".",   mods = "LEADER",       action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
  {
    key = "!",
    mods = "LEADER | SHIFT",
    action = wezterm.action_callback(function(win, pane)
      local _tab, _window = pane:move_to_new_tab()
    end),
  },
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Renaming Tab Title...:" },
      }),
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  -- Split panes
  { key = '\\',         mods = 'LEADER',     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '\\',         mods = 'LEADER|ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Navigate panes
  { key = 'LeftArrow',  mods = 'LEADER',     action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'LEADER',     action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'LEADER',     action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'LEADER',     action = wezterm.action.ActivatePaneDirection 'Down' },

  -- Zoom
  { key = '=',          mods = 'LEADER',     action = wezterm.action.IncreaseFontSize },
  { key = '-',          mods = 'LEADER',     action = wezterm.action.DecreaseFontSize },
  { key = '0',          mods = 'LEADER',     action = wezterm.action.ResetFontSize },

  -- Copy/Paste
  { key = 'c',          mods = 'LEADER',     action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v',          mods = 'LEADER',     action = wezterm.action.PasteFrom 'Clipboard' },

  -- Fullscreen
  { key = 'F11',        mods = '',           action = wezterm.action.ToggleFullScreen },
}

config.mouse_bindings = {
  -- Right click pastes from clipboard
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom("Clipboard"),
  },
  -- Ctrl+click opens the link under the cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },
  -- Scroll down with CTRL to zoom out (decrease font size)
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
}

config.key_tables = {
  resize_pane = {
    { key = "<",      action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "-",      action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "+",      action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = ">",      action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h",      action = act.MoveTabRelative(-1) },
    { key = "l",      action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
}

-- Allows me to cycle through tabs with Leader + 1 - 9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

-- ============================================================================
-- SHELL CONFIGURATION UNTUK WINDOWS POWERSHELL
-- ============================================================================

config.default_domain = 'local'

-- PowerShell configuration
if wezterm.target_triple:find 'windows' then
  config.default_prog = {
    'pwsh',
    '-NoLogo',
    '-NoExit',
  }
end

-- ============================================================================
-- PERFORMANCE DAN BEHAVIOR
-- ============================================================================

config.default_cursor_style = 'BlinkingBlock'
config.animation_fps = 60
config.cursor_blink_rate = 300
config.window_background_opacity = 0.9
config.text_background_opacity = 1.0
config.hide_tab_bar_if_only_one_tab = false

-- Scrollback buffer
config.scrollback_lines = 3500

-- Bell notification
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}
config.enable_scroll_bar = false

-- Copy/paste behavior
config.selection_word_boundary = ' \t\n{}[]()"\','

-- ============================================================================
-- STATUS AREA (Right side info)
-- ============================================================================
wezterm.on("update-status", function(window, pane)
  local date = wezterm.strftime("%a %b %-d  %H:%M")

  local hostname = wezterm.hostname()
  hostname = hostname:gsub("%.local$", "")

  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = custom_colors.red
  -- It's a little silly to have workspace name all the time
  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = custom_colors.cyan
  end
  if window:leader_is_active() then
    stat = "LDR"
    stat_color = custom_colors.magenta
  end

  local basename = function(s)
    -- Nothing a little regex can't fix
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  -- Current working directory
  local cwd = pane:get_current_working_dir()
  if cwd then
    cwd = basename(cwd.file_path) --> URL object introduced in 20240127-113634-bbcac864 (type(cwd) == "userdata")
    -- cwd = basename(cwd) --> 20230712-072601-f4abf8fd or earlier version
  else
    cwd = ""
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
  cmd = cmd and basename(cmd) or ""

  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#6e6a86" } },
    { Text = "  " },
    { Foreground = { Color = stat_color } },
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Foreground = { Color = "#403d52" } },
    { Text = "  │  " },
    { Foreground = { Color = "#908caa" } },
    { Text = wezterm.nerdfonts.oct_clock .. "  " .. date .. "  " },
    { Background = { Color = '#140e1a' } },
    { Foreground = { Color = "#403d52" } },
  }))
end)

-- ============================================================================
-- MISC SETTINGS
-- ============================================================================

config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.enable_wayland = false -- For maximum compatibility on Windows

return config

