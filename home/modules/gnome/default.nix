{ config, lib, ... }:

with lib.hm.gvariant;

{

  home.file."dracula.png" = {
    source = ./dracula.png;
    target = ".local/share/backgrounds/dracula.png";
  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      enable-animations = true;
      font-antialiasing = "rgba";
      font-hinting = "full";
      gtk-theme = "dracula-gtk";
      icon-theme = "Yaru-purple-dark";
      locate-pointer = true;
    };

    "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

    "org/gnome/shell/extensions/libpanel" = {
      row-spacing = 24;
      padding = 20;
    };

    "org/gnome/shell/extensions/unite" = {
      desktop-name-text = "rembot";
      enable-titlebar-actions = true;
      extend-left-box = false;
      greyscale-tray-icons = true;
      hide-activities-button = "always";
      hide-app-menu-icon = true;
      hide-dropdown-arrows = true;
      hide-window-titlebars = "maximized";
      notifications-position = "right";
      reduce-panel-spacing = false;
      show-desktop-name = false;
      show-legacy-tray = true;
      show-window-buttons = "maximized";
      show-window-title = "never";
      window-buttons-theme = "auto";
    };

    "org/gnome/shell/extensions/bluetooth-quick-connect" = {
      bluetooth-auto-power-on = true;
      refresh-button-on = true;
      show-battery-value-on = false;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.7;
      sigma = 35;
    };

    "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = {
      compatibility = false;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/dracula.png";
      picture-uri-dark =
        "file:///home/dustin/.local/share/backgrounds/dracula.png";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/dracula.png";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/mutter" = {
      center-new-windows = true;
      edge-tiling = false; # for pop-shell
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/peripherals/mouse" = { natural-scroll = false; };

    "org/gnome/settings-daemon/plugins/color" = { night-light-enabled = true; };

    "org/gnome/shell/extensions/appindicator" = {
      legacy-tray-enabled = true;
      tray-pos = "right";
    };

    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      active-hint-border-radius = mkUint32 4;
      fullscreen-launcher = true;
      mouse-cursor-follows-active-window = false;
      show-title = true;
      smart-gaps = true;
      tile-by-default = true;
      hint-color-rgba = "rgb(141,118,191)";
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "quick-settings-audio-panel@rayzeq.github.io"
        "unite@hardpixel.eu"
        "appindicatorsupport@rgcjonas.gmail.com"
        "bluetooth-quick-connect@bjarosze.gmail.com"
        "blur-my-shell@aunetx"
        "just-perfection-desktop@just-perfection"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        # "forge@jmmaranan.com"
        "pop-shell@system76.com"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = { name = "dracula-gtk"; };

    "org/gnome/shell/extensions/quick-settings-audio-panel" = {
      always-show-input-slider = true;
      media-control = "move";
      merge-panel = true;
      move-master-volume = true;
      panel-position = "bottom";

    };

    "org/gnome/shell/extensions/just-perfection" = {
      theme = true;
      window-picker-icon = true;
      window-demands-attention-focus = false;
      startup-status = 1;
      ripple-box = true;
      dash-icon-size = 0;
      app-menu-icon = true;
      workspaces-in-app-grid = true;
      workspace = true;
      workspace-background-corner-size = 0;
      show-apps-button = true;
      search = true;
      app-menu = true;
      panel = true;
      double-super-to-appgrid = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      switch-applications = [ "<Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Alt>Tab" ];
      # switch-windows = [ "<Alt>Tab" ];
      # switch-windows-backward = [ "<Shift><Alt>Tab" ];
      toggle-fullscreen = [ "<Super>f" ];
      maximize = [ "<Super>m" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      toggle-message-tray = [ "<Shift><Super>n" ];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Control><Alt>p" ];
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      toggle-message-tray = [ "<Shift><Super>n" ];
    };

    "org/gnome/Console" = {
      theme = "auto";
      font-scale = 1.5;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>t";
        # command = "kgx";
        command = "alacritty";
        name = "Terminal";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
      {
        binding = "<Control><Alt>a";
        command = "/etc/profiles/per-user/dustin/bin/screenshot-annotate.sh";
        name = "Annotate Screenshot";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
      {
        binding = "<Super>b";
        command = "chromium-browser";
        name = "Browser";
      };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" =
      {
        binding = "<Super>e";
        command = "code";
        name = "Editor";
      };

  };

  home.file.".face" = {
    source = ./.face;
    target = ".face";
  };
}
