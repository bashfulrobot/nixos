{ config, lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      enable-animations = true;
      font-antialiasing = "rgba";
      font-hinting = "full";
      gtk-theme = "Yaru-blue-dark";
      icon-theme = "Yaru-bark-dark";
      locate-pointer = true;
    };

    "org/gnome/shell/extensions/unite" = {
      enable-titlebar-actions = true;
      greyscale-tray-icons = true;
      hide-activities-button = "always";
      hide-app-menu-icon = true;
      hide-dropdown-arrows = true;
      hide-window-titlebars = "maximized";
      notifications-position = "right";
      reduce-panel-spacing = true;
      show-desktop-name = false;
      show-legacy-tray = true;
      show-window-buttons = "maximized";
      show-window-title = "never";
      window-buttons-theme = "auto";
    };

    "org/gnome/shell/extensions/bluetooth-quick-connect" = {
      bluetooth-auto-power-on = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri =
        "file:///home/dustin/Pictures/bluefin/WallPaper_SpringNight_Post.webp";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri =
        "file:///home/dustin/Pictures/bluefin/WallPaper_AutumnNight_Post.webp";
    };

    "org/gnome/mutter" = { center-new-windows = true; };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/peripherals/mouse" = { natural-scroll = false; };

    "org/gnome/settings-daemon/plugins/color" = { night-light-enabled = true; };

    "org/gnome/shell" = {
      enabled-extensions =
        "['quick-settings-audio-panel@rayzeq.github.io', 'unite@hardpixel.eu', 'appindicatorsupport@rgcjonas.gmail.com', 'bluetooth-quick-connect@bjarosze.gmail.com', 'blur-my-shell@aunetx', 'just-perfection-desktop@just-perfection', 'user-theme@gnome-shell-extensions.gcampax.github.com']";
    };

    "org/gnome/shell/extensions/user-theme" = { name = "Yaru-blue-dark"; };

    "org/gnome/shell/extensions/quick-settings-audio-panel" = {
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
      close = "['<Super>q']";
      switch-applications = "['<Alt>Tab']";
      switch-applications-backward = "['<Shift><Alt>Tab']";
    };

    "org/gnome/Console" = {
      theme = "auto";
      font-scale = 1.5;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Super>t";
        command = "kgx";
        name = "Terminal";
      };

  };

  home.file.".face" = {
    source = ./.face;
    target = ".face";
  };
}
