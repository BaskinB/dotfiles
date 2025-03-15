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
komorebi:
  start_command: "komorebic start --whkd"
  stop_command: "komorebic stop --whkd"
  reload_command: "komorebic stop --whkd && komorebic start --whkd"
```

### Bar Settings

These are the main bar's settings, really the only stuff that pertains to us is the alignment settings, the bur effect, etc etc. in the future I'd like to move away from sqaured buttons and use workspace names and adopt a more TUI Textfox/Spicifey Text theme style for this will do for now.

```yaml
bars:
  primary-bar:
    enabled: true
    screens: ['*'] 
    class_name: "yasb-bar"
    alignment:
      position: "top"
      center: false
    blur_effect:
      enabled: true
      acrylic: false
      dark_mode: true
      round_corners: true
      border_color: "None"
    window_flags:
      always_on_top: true
      windows_app_bar: true
      hide_on_fullscreen: true
    dimensions:
      width: "100%"
      height: 32
    padding:
      top: 8
      left: 12
      bottom: 0
      right: 12
    widgets:
      left:
        [
          "home",
          "komorebi_workspaces",
          "komorebi_active_layout",
          "active_window",
        ]
      center:
        ["clock"]
      right:
        [
          "cava",
          "media",
          "volume",
          "weather",
          "github",
          "disk",
          "wallpapers",
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
      - { title: "Downloads", path: "~\\Downloads"}
      - { title: "Documents", path: "~\\Documents"}
      - { title: "Pictures", path: "~\\Pictures"}
      - { title: "Videos", path: "~\\Videos"}
      system_menu: true
      power_menu: false
      blur: true
      round_corners: true
      round_corners_type: "normal"
      border_color: ""
      distance: 5
      container_padding: 
        top: 0
        left: 0
        bottom: 0
        right: 0
      alignment: "left"
      direction: "down"
      menu_labels:
        shutdown: "Shutdown"
        restart: "Restart"
        logout: "Logout"
        lock: "Lock"
        sleep: "Sleep"
        system: "System Settings"
        about: "About This PC"
        task_manager: "Task Manager"
  komorebi_workspaces:
    type: "komorebi.workspaces.WorkspaceWidget"
    options:
        label_offline: "\u26a1 Offline"
        label_workspace_btn: "{name}"
        label_workspace_active_btn: "{name}"
        label_workspace_populated_btn: "{name}"
        label_default_name: "{index}"
        label_zero_index: false
        hide_empty_workspaces: true
        hide_if_offline: true
        animation: true
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
  weather:
    type: "yasb.weather.WeatherWidget"
    options:
      label: "<span>{icon}</span> {temp}"
      label_alt: "<span>{icon}</span> {location}: Min {min_temp}, Max {max_temp}, Humidity {humidity}"
      api_key: '3bf4cf9a7c3f40d6b31174128242807'
      update_interval: 600 #Update interval in seconds, Min 600
      hide_decimal: true
      location: 'Lincoln, NE, 68523'
      units: "imperial" # Can be 'metric' or 'imperial'
      callbacks:
        on_left: "toggle_label"
      icons:
        sunnyDay: "\udb81\udd99"
        clearNight: "\udb81\udd99"
        cloudyDay: "\udb81\udd99"
        cloudyNight: "\udb81\udd99"
        rainyDay: "\udb81\udd99"
        rainyNight: "\udb81\udd99"
        snowyIcyDay: "\udb81\udd99"
        snowyIcyNight: "\udb81\udd99"
        blizzard: "\udb81\udd99"
        default: "\udb81\udd99" 
  media:
      type: "yasb.media.MediaWidget"
      options:
        label: "{title}"
        label_alt: "{artist}"
        max_field_size:
          label: 25
          label_alt: 25
        show_thumbnail: false
        controls_only: false
        controls_left: true
        hide_empty: true
        thumbnail_alpha: 250
        thumbnail_padding: 8
        thumbnail_corner_radius: 0
        icons:
          prev_track: ""
          next_track: ""
          play: "<span>\uf001</span>"
          pause: "<span>\uf001</span>"
  active_window:
    type: "yasb.active_window.ActiveWindowWidget"
    options:
      label: "{win[title]}"
      label_alt: "[class_name='{win[class_name]}' exe='{win[process][name]}' hwnd={win[hwnd]}]"
      label_no_window: ""
      label_icon: true
      label_icon_size: 14
      max_length: 36
      max_length_ellipsis: "..."
      monitor_exclusive: true
  volume:
    type: "yasb.volume.VolumeWidget"
    options:
      label: "<span>{icon}</span> {level}"
      label_alt: "{volume}"
      volume_icons:
        - "\ueee8"  # Icon for muted
        - "\uf026"  # Icon for 0-10% volume
        - "\uf027"  # Icon for 11-30% volume
        - "\uf027"  # Icon for 31-60% volume
        - "\uf028"  # Icon for 61-100% volume
      callbacks:
        on_right: "exec cmd.exe /c start ms-settings:sound"
  clock:
    type: "yasb.clock.ClockWidget"
    options:
      label: "{%D %H:%M %p}"
      label_alt: "{%A, %d %B %Y %H:%M}"
      timezones: []
      calendar:
        alignment: "center"
  disk:
    type: "yasb.disk.DiskWidget"
    options:
        label: "<span>\uf473</span>"
        label_alt: "<span>\uf473</span>"
        update_interval: 60
        group_label:
          volume_labels: ["C", "D", "E", "F"]
          show_label_name: false
          blur: True
          round_corners: True
          round_corners_type: "small"
          border_color: "System"
          alignment: "right"
          direction: "down"
          distance: 6
        callbacks:
          on_left: "toggle_group"
          on_middle: "toggle_label"
          on_right: "exec explorer C:\\" # Open disk C in file explorer
  wallpapers:
    type: "yasb.wallpapers.WallpapersWidget"
    options:
      label: "<span>\udb83\ude09</span>"
      image_path: "~\\.config\\Wallpapers"
      change_automatically: false
      update_interval: 60
      gallery:
        enabled: true
        blur: true
        image_width: 296
        image_per_page: 6
        show_buttons: true
        orientation: "portrait"
        image_spacing: 10
        lazy_load: true
        lazy_load_delay: 10
        lazy_load_fadein: 200
        image_corner_radius: 20
        enable_cache: true
  power_menu:
      type: "yasb.power_menu.PowerMenuWidget"
      options:
        label: "\uf011"
        uptime: True
        blur: False
        blur_background: True
        animation_duration: 250 # Milisecond 
        button_row: 5 # Number of buttons in row, min 1 max 5
        buttons:
          signout: ["\udb80\udf43","Sign out"]
          shutdown: ["\uf011","Shut Down"]
          restart: ["\uead2","Restart"]
          hibernate: ["\uf28e","Hibernate"]
          cancel: ["\udb81\udf3a","Cancel"]
  cava:
    type: "yasb.cava.CavaWidget"
    options:
      bar_height: 12
      gradient: 1
      reverse: 0
      sensitivity: 100
      foreground: "#fffff"
      gradient_color_1: '#74c7ec'
      gradient_color_2: '#89b4fa'
      gradient_color_3: '#cba6f7'
      bars_number: 8
      bar_spacing: 2
      bar_width: 4
      sleep_timer: 0
      hide_empty: true
      container_padding:
        top: 0
        left: 0
        bottom: 0
        right: 0
  github:
    type: "yasb.github.GithubWidget"
    options:
      label: "<span>\ueba1</span>"
      label_alt: "Notifications {data}" # {data} return number of unread notification
      token: env # GitHub Personal access tokens (classic) https://github.com/settings/tokens
      max_notification: 20 # Max number of notification displaying in menu max: 50
      only_unread: false # Show only unread or all notifications; 
      max_field_size: 54 # Max characters in title before truncation.
      update_interval: 300 # Check for new notification in seconds
      menu:
        blur: True # Enable blur effect for the menu
        round_corners: True # Enable round corners for the menu (this option is not supported on Windows 10)
        round_corners_type: "normal" # Set the type of round corners for the menu (normal, small) (this option is not supported on Windows 10)
        border_color: "System" # Set the border color for the menu (this option is not supported on Windows 10)
        alignment: "right"
        direction: "down"
        distance: 6
```
