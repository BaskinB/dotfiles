---
title: "YASB Config"
author: "BaskinB"
tangle: "./yasb/config.yaml"
---

# YASB Config <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->

- [About This Configuration](#about-this-configuration)
  - [Main Settings](#main-settings)
  - [Bar Settings](#bar-settings)
  - [Widgets Configuration](#widgets-configuration)

## About This Configuration

![image](https://media.discordapp.net/attachments/964423486758064128/1348829360509157376/image.png?ex=67d0e2bb&is=67cf913b&hm=5756ab15c364c58005e330c5edb54e4a2805503d91eb80bd8aee3003cdcea427&=&format=webp&quality=lossless&width=1860&height=698)

This is a configuration file for the YASB-Reborn Project originally provided by the YASB-Reborn Themes repo and has been adapted to my colorscheme/style but at it's core it is their config.

YASB or Yet Another Top Bar is a Top Bar for windows written in the Rust language, I primarily use it for its komorebi widget to go along side my main Komorebi Config which you can fine [here](#bar-settings)

### Main Settings

These are the simple configuration settings for stuff like watching the config and styles.css to live update them upon saving

```yaml
watch_stylesheet: true
watch_config: true
debug: false
```

### Bar Settings

These are the main bar's settings, really the only stuff that pertains to us is the alignment settings, the bur effect, etc etc. in the future I'd like to move away from sqaured buttons and use workspace names and adopt a more TUI Textfox/Spicifey Text theme style for this will do for now.

```yaml
bars:
  primary-bar:
    enabled: true
    screens: ["*"] # "*" for all screens
    class_name: "yasb-bar"
    alignment:
      position: "top"
      center: false
    animation:
      enabled: true
      duration: 1000
    blur_effect:
      enabled: false
      acrylic: false
      dark_mode: false
      round_corners: false
      round_corners_type: "normal"
      border_color: "System"
    window_flags:
      always_on_top: false
      windows_app_bar: true
    dimensions:
      width: "100%"
      height: 35
    padding:
      top: 4
      left: 6
      bottom: 0
      right: 6
    widgets:
      left: [
        "home",
        "komorebi_workspaces",
        "komorebi_active_layout",
      ]
      center: [
        "active_window",
      ]
      right: [
        "memory",
        "volume",
        "clock",
        "power_menu"
      ]
```

### Widgets Configuration

This is the configuration settings for all of the widgets defined in the bar configuration above.

```yaml
widgets:
  home:
    type: "yasb.home.HomeWidget"
    options:
      label: "<span>🦥Baskin</span>"
      menu_list:
      - { title: "Home", path: "~" }
      - { title: "Download", path: "~\\Downloads" }
      - { title: "Documents", path: "~\\Documents" }
      system_menu: true
      power_menu: true
      blur: false
  memory:
    type: "yasb.memory.MemoryWidget"
    options:
      label: "<span>\uf4bc</span> {virtual_mem_outof}"
      label_alt: "<span>\uf4bc</span> {virtual_mem_outof}"
      update_interval: 10000
      callbacks:
        on_right: "exec cmd /c Taskmgr"
  active_window:
    type: "yasb.active_window.ActiveWindowWidget"
    options:
      label: "{win[title]}"
      label_alt: "[class_name='{win[class_name]}' exe='{win[process][name]}' hwnd={win[hwnd]}]"
      label_no_window: ""
      label_icon: true
      label_icon_size: 14
      max_length: 56
      max_length_ellipsis: "..."
      monitor_exclusive: false
  clock:
    type: "yasb.clock.ClockWidget"
    options:
      label: "{%m/%d/%Y %I:%M}"
      label_alt: "{%A, %B %d, %Y %I:%M %p}"
      timezones: []
      callbacks:
        on_left: "toggle_label"
  komorebi_workspaces:
    type: "komorebi.workspaces.WorkspaceWidget"
    options:
      label_offline: "\u23fc Offline"
      label_workspace_btn: "{name}"
      label_workspace_active_btn: ""
      label_workspace_populated_btn: "{name}"
      label_default_name: "{index}"
      label_zero_index: false
      hide_empty_workspaces: true
      hide_if_offline: true
      animation: false
      container_padding:
        top: 0
        left: 8
        bottom: 0
        right: 8
  komorebi_active_layout:
    type: "komorebi.active_layout.ActiveLayoutWidget"
    options:
      hide_if_offline: false
      label: "{icon}"
      layouts: ['bsp', 'columns', 'rows', 'grid', 'vertical_stack', 'horizontal_stack', 'ultrawide_vertical_stack']
      layout_icons:
        bsp: "[]="
        columns: "[||]"
        rows: "[==]"
        grid: "[G]"
        vertical_stack: "[V]="
        horizontal_stack: "[H]="
        ultrawide_vertical_stack: "||="
        monocle: "[M]"
        maximised: "[X]"
        floating: "><>"
        paused: "[P]"
      container_padding:
        top: 0
        left: 8
        bottom: 0
        right: 8
      callbacks:
        on_left: "next_layout"
        on_middle: "toggle_monocle"
        on_right: "prev_layout"
  volume:
    type: "yasb.volume.VolumeWidget"
    options:
      label: "<span>{icon}</span> {level}"
      label_alt: "{volume}"
      tooltip: false
      volume_icons:
        - "\ueee8"
        - "\uf026"
        - "\uf027"
        - "\uf027"
        - "\uf028"
      callbacks:
        on_left: "toggle_mute"
        on_right: "exec cmd.exe /c start ms-settings:sound"
  power_menu:
    type: "yasb.power_menu.PowerMenuWidget"
    options:
      label: "\uf011"
      uptime: True
      blur: False
      blur_background: True
      animation_duration: 200
      button_row: 5
      buttons:
        shutdown: ["\uf011", "Shut Down"]
        restart: ["\uead2", "Restart"]
        signout: ["\udb80\udf43", "Sign out"]
        hibernate: ["\uf28e", "Hibernate"]
        sleep: ["\u23fe", "Sleep"]
        cancel: ["", "Cancel"]
```
