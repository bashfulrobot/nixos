{ config, lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-hinting = "full";
      font-antialiasing = "rgba";
      gtk-theme = "Yaru-blue-dark";
      icon-theme = "Yaru-bark-dark";
      cursor-theme = "Yaru";
      locate-pointer = true;
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
        "['user-theme@gnome-shell-extensions.gcampax.github.com']";
    };

    "org/gnome/shell/extensions/user-theme" = { name = "Yaru-blue-dark"; };

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
