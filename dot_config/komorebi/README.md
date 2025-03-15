---
title: "Komorebi Config"
author: "BaskinB"
tangle: "./komorebi/komorebi.json"
---
<!-- omit in toc -->
# Komorebi Config  

<!-- omit in toc -->
## Table of Contents

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

This a a literate configuration file is for Komorebi, a tiling window manager for Windows. It defines various settings and behaviors for window management, including core settings, window and monitor behavior, workspace padding, border settings, stackbar settings, ignore rules, display index preferences, and monitor-specific workspace configurations.

### Core Settings

```json
{
  "$schema": "https://raw.githubusercontent.com/LGUG2Z/komorebi/v0.1.34/schema.json",
  "app_specific_configuration_path": "$Env:KOMOREBI_CONFIG_HOME/applications.json",
```

### Window/Monitor Behaviour

```json
  "window_hiding_behaviour": "Cloak",
  "cross_monitor_move_behaviour": "Insert",
  "mouse_follows_focus": false,
```

### Workspace Padding

```json
  "default_workspace_padding": 4,
  "default_container_padding": 4, 
```

### Border Settings

```json
  "border": true,
  "border_width": 3,
  "border_offset": -1,
  "border_colours": {
    "single": "#e61bfc",
    "stack": "#e61bfc",
    "floating": "#62cbff",
    "unfocused": "#3d375e7f",
    "monocle": "#ff6767"
  },
```

### Stackbar Settings

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
    }
  ],
```

### Display Index Preferences

```json
  "display_index_preferences": {
    "0": "GSM5C1A-5&be88bcd&2&UID176385",
    "1": "ACI23B1-5&be88bcd&2&UID176384"
  },
```

### Monitors and Workspaces

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
            }
          ]
        },
        {
          "name": "[web]",
          "layout": "BSP",
          "initial_workspace_rules": [
            {
              "kind": "Exe",
              "id": "brave.exe",
              "matching_strategy": "Equals"
            }
          ]
        },
        {
          "name": "[comms]",
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
          "name": "[files]",
          "layout": "BSP",
          "initial_workspace_rules": [
            {
              "kind": "Exe",
              "id": "Explorer.exe",
              "matching_strategy": "Equals"
            },
            {
              "kind": "Exe",
              "id": "wezterm-gui.exe",
              "matching_strategy": "Equals"
            }
          ]
        },
        {
          "name": "[media]",
          "layout": "Rows"
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
          "name": "[other]",
          "layout": "RightMainVerticalStack"
        }
      ]
    }
  ]
}
```