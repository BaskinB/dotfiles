---
author: "BaskinB"
tangle: "./komorebi/komorebi.json"
---

# Komorebi Config <!-- omit from toc -->

## Table of Contents <!-- omit from toc -->

- [About this Config](#about-this-config)
  - [Core Settings](#core-settings)
  - [Window/Monitor Behaviour](#windowmonitor-behaviour)
  - [Workspace Padding](#workspace-padding)
  - [Border Settings](#border-settings)
  - [Stackbar Settings](#stackbar-settings)
  - [Ignore Rules](#ignore-rules)
  - [Display Index Preferences](#display-index-preferences)
  - [Monitors and Workspaces](#monitors-and-workspaces)
    - [Monitor 1](#monitor-1)
    - [Monitor 2](#monitor-2)

## About this Config

This a literate configuration file is for Komorebi, a tiling window manager for Windows. It defines various settings and behaviors for window management. including core settings, window and monitor behavior, workspace padding, border settings, stackbar settings, ignore rules, display index preferences, and monitor-specific workspace configurations.

### Core Settings

Set the schema version to use for the Komorebi Config, then we set our app config location to the `KOMOREBI_CONFIG_HOME` Environment Variable which directs to `.config/komorebi`

```json
{
  "$schema": "https://raw.githubusercontent.com/LGUG2Z/komorebi/v0.1.36/schema.json",
  "app_specific_configuration_path": "$Env:KOMOREBI_CONFIG_HOME/applications.json",
```

### Window/Monitor Behaviour

Sets our window hiding behavior to `Cloak` and monitor move behavior to `Insert`, we then set mouse follow focux to true to keep a keyboard centric workflow, otherwise the window focus can't move across monitors unless the mouse is within that monitor's workspace.

Then we set our Animation settings for windows with the duration, fps and style in this case `EaseOutBack`.

```json
  "window_hiding_behaviour": "Cloak",
  "window_container_behaviour": "Create",
  "cross_monitor_move_behaviour": "Insert",
  "mouse_follows_focus": true,
  "animation": {
    "enabled": true,
    "duration": 250,
    "fps": 120,
    "style": {
      "movement": "EaseOutBack",
      "transparency": "Linear"
    }
  },
```

### Workspace Padding

Similar to other `Tiling Window Managers` out there the `workspace padding` option in Komorebi act as our Gaps between windows and the edge of our screens.

```json
  "default_workspace_padding": 4,
  "default_container_padding": 4,

  "global_work_area_offset": {
    "bottom": 4,
    "left": 4,
    "right": 4,
    "top": 2
  },
```

### Border Settings

These are the settings for the border around the windows as well as the colors for each mode such as floating, stacked, single window, unfocused, etc etc.

```json
  "border": true,
  "border_width": 3,
  "border_offset": -1,
  "border_colours": {
    "single": "#4eddff",
    "stack": "#61ffca",
    "floating": "#62cbff",
    "unfocused": "#e92bff",
    "monocle": "#ff6767"
  },
```

### Stackbar Settings

This can be ignored I don't make use of it in my config.

```json
  "stackbar": {
    "height": 40,
    "mode": "Never",
    "tabs": {
      "width": 125
    }
  },
```

### Ignore Rules

These are our ignore rules, they tell Komorebi whether or not to ignore and not manage certain windows, this comes especially in handy with Video Games or applications that need to be full screen.

```json
  "ignore_rules": [
    {
      "kind": "Exe",
      "id": "Yasb.exe",
      "matching_strategy": "Equals"
    },
    {
      "kind": "Title",
      "id": "[Pp]icture.in.[Pp]icture",
      "matching_strategy": "Regex"
    },
    {
      "kind": "Title",
      "id": "Chrome_WidgetWin_1|MozillaDialogClass",
      "matching_strategy": "Regex"
    },
    {
      "kind": "Title",
      "id": "HwndWrapper[PowerToys.PowerAccent.*?]",
      "matching_strategy": "Regex"
    },
    {
      "kind": "Title",
      "id": "HwndWrapper",
      "matching_strategy": "Regex"
    },
    {
      "kind": "Title",
      "id": ".*? - Peek",
      "matching_strategy": "Regex"
    },
    {
      "kind": "Title",
      "id": "Lively",
      "matching_strategy": "Equals"
    },
    {
      "kind": "Title",
      "id": "PokeMMO|RDR2|RedM|RedM_b1491_GTAProcess|amtrucks|FiveM_b1604_GTAProcess|FiveM|PlayGTAV|GTA5|swtor|heidisql",
      "matching_strategy": "Regex"
    },
    {
      "kind": "Exe",
      "matching_strategy": "Equals",
      "id": "KINGDOM HEARTS III.exe"
    },
    { "kind": "Exe", "matching_strategy": "Equals", "id": "inZOI.exe" },
    { "kind": "Exe", "matching_strategy": "Equals", "id": "mousemaster.exe" },
    {
      "kind": "Exe",
      "matching_strategy": "Equals",
      "id": "obs-browser-page.exe"
    },
    { "kind": "Exe", "matching_strategy": "Equals", "id": "ContractVille.exe" }
  ],
```

### Display Index Preferences

We set a display index so that Komorebi can determine which monitor is which to apply our workspace settings and rules for them see [Monitors and Workspaces](#monitors-and-workspaces)

```json
  "display_index_preferences": {
    "0": "GSM5C1A-5&be88bcd&2&UID176385",
    "1": "ACI23B1-5&be88bcd&2&UID176384"
  },
```

### Monitors and Workspaces

We define our workspace settings per Monitor, each monitors workspaces need to have unique named otherwise they conflict and Komorebi doesn't know how to differ which monitor workspace is which, especially with things like workspace rules for sending Applications to certain workspaces.

#### Monitor 1

```json
  "monitors": [
    {
      "workspaces": [
        {
          "name": "[home]",
          "layout": "BSP",
          "workspace_rules": [
            {
              "kind": "Exe",
              "id": "Code.exe",
              "matching_strategy": "Equals"
            },
          ]
        },
        {
          "name": "[web]",
          "layout": "BSP",
          "initial_workspace_rules": [
            {
              "kind": "Exe",
              "id": "zen.exe",
              "matching_strategy": "Equals"
            }
          ]
        },
        {
          "name": "[chat]",
          "layout": "HorizontalStack",
          "initial_workspace_rules": [
            {
              "kind": "Exe",
              "id": "Discord.exe",
              "matching_strategy": "Equals"
            }
          ]
        },
        {
          "name": "[sys]",
          "layout": "BSP",
          "initial_workspace_rules": [
            {
              "kind": "Exe",
              "id": "Explorer.exe",
              "matching_strategy": "Equals"
            },
            {
              "kind": "Exe",
              "id": "warp.exe",
              "matching_strategy": "Equals"
            }
          ]
        }
      ]
    },
```

#### Monitor 2

```json
    {
      "workspaces": [
        {
          "name": "[obs]",
          "layout": "BSP"
        },
        {
          "name": "[media]",
          "layout": "Rows",
          "initial_workspace_rules": [
            {
              "kind": "Exe",
              "id": "Spotify.exe",
              "matching_strategy": "Equals"
            }
          ]
        },
        {
          "name": "[other]",
          "layout": "RightMainVerticalStack"
        }
      ]
    }
  ]
}
```
